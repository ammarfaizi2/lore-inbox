Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUKVBEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUKVBEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUKVBEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:04:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261881AbUKVBCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:02:55 -0500
Date: Mon, 22 Nov 2004 01:02:53 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in fs/fcntl.c
Message-ID: <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 11:55:23PM +0100, Jesper Juhl wrote:
> This patch removes a pointless comparison. "arg" is an unsigned long, thus 
> it can never be <0, so testing that is pointless.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
>  	case F_SETSIG:
>  		/* arg == 0 restores default behaviour. */
> -		if (arg < 0 || arg > _NSIG) {
> +		if (arg > _NSIG) {
>  			break;

I've seen patches like this before.  I'm generally in favour of removing
the unnecessary test, but Linus rejected it on the grounds the compiler
shouldn't be warning about it and it's better to be more explicit about
the range test.  Maybe he's changed his mind between then and now ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
