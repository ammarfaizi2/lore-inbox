Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbUKVW1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUKVW1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUKVW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:27:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:62093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262446AbUKVWZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:25:47 -0500
Date: Mon, 22 Nov 2004 14:25:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Hearn <mh@codeweavers.com>
cc: Eric Pouech <pouech-eric@wanadoo.fr>, Jesse Allen <the3dfxdude@gmail.com>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <1101161953.13273.7.camel@littlegreen>
Message-ID: <Pine.LNX.4.58.0411221424080.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <419E42B3.8070901@wanadoo.fr>  <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
  <419E4A76.8020909@wanadoo.fr>  <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
  <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org> 
 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>  <20041120214915.GA6100@tesore.ph.cox.net>
 <41A251A6.2030205@wanadoo.fr>  <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
 <1101161953.13273.7.camel@littlegreen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Mike Hearn wrote:
> 
> this is where signals are converted to SEH exceptions (w-exceptions as
> Eric called them):
> 
>   dlls/ntdll/signal_i386.c 

Looks like it clears TF there already:

        if (context->EFlags & 0x100)
        {
            context->EFlags &= ~0x100;  /* clear single-step flag */
        }

so I'll just assume it's ok. 

		Linus
