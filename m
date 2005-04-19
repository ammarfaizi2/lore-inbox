Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVDSOkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVDSOkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVDSOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:40:07 -0400
Received: from mail.dif.dk ([193.138.115.101]:45016 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261568AbVDSOi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:38:27 -0400
Date: Tue, 19 Apr 2005 16:41:29 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, vital@ilport.com.ua
Subject: Re: [PATCH] sha512: replace open-coded be64 conversions
In-Reply-To: <200504191712.09590.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.62.0504191635370.2074@dragon.hyggekrogen.localhost>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
 <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.62.0504191102360.2480@dragon.hyggekrogen.localhost>
 <200504191712.09590.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Denis Vlasenko wrote:

> On Tuesday 19 April 2005 12:04, Jesper Juhl wrote:
> > On Tue, 19 Apr 2005, Denis Vlasenko wrote:
> > 
> > > This + next patch were "modprobe tcrypt" tested.
> > > See next mail.
> > 
> > Could you please send patches inline instead of as attachments. 
> > Attachments mean there's more work involved in getting at them to read 
> > them, and they are a pain when you want to reply and quote the patch to 
> > comment on it.
> > Thanks.
> 
> I'm afraid Kmail tend to subtly mangle inlined patches.
> Then people start to complain that patch does not apply, and rightly so. :(
> 
> However, I can try.
> 
Thanks.

A few small comments below.


[...]
> @@ -483,12 +483,8 @@ static int anubis_setkey(void *ctx_arg, 
>  	ctx->R = R = 8 + N;
>  
>  	/* * map cipher key to initial key state (mu): */
> -		for (i = 0, pos = 0; i < N; i++, pos += 4) {
> -		kappa[i] =
> -			(in_key[pos    ] << 24) ^
> -			(in_key[pos + 1] << 16) ^
> -			(in_key[pos + 2] <<  8) ^
> -			(in_key[pos + 3]      );
> +	for (i = 0; i < N; i++) {
> +		kappa[i] = be32_to_cpu( ((__be32*)in_key)[i] );
                                         ^^^^^^^            ^
                 is this cast really nessesary ?      No space there.
>  	}
        ^
     Those braces are superfluous.

[...]


Same comments for the rest of it. There seems to be a lot of unneeded 
casts (I could be wrong, but I don't see the need for them, and if they 
are not needed all they do is mask potential type errors). And the 
whitespace thing also goes for the rest, don't put extra spaces after the 
opening parenthesis and before the closing one in function calls.


-- 
Jesper Juhl


