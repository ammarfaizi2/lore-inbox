Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUFBRe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUFBRe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUFBRey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:34:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:50397 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263766AbUFBRe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:34:27 -0400
Date: Wed, 2 Jun 2004 10:32:00 -0700
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602173200.GA12254@kroah.com>
References: <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org> <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org> <20040602152741.GC26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020839230.3403@ppc970.osdl.org> <20040602161721.GA29296@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020921220.3403@ppc970.osdl.org> <20040602171732.GA30427@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602171732.GA30427@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 07:17:32PM +0200, J?rn Engel wrote:
> 
> Leaves usb_audio_recurseunit() as the only function in question, that
> one could actually be sane, although it looks rather interesting:
> WARNING: trivial recursion detected:
>        0  usb_audio_recurseunit
> WARNING: recursion detected:
>       16  usb_audio_selectorunit
>        0  usb_audio_recurseunit
> WARNING: multiple recursions around usb_audio_recurseunit()
> WARNING: recursion detected:
>        0  usb_audio_recurseunit
>        0  usb_audio_processingunit
> 
> Greg, can you say whether this construct makes sense?

Well it's sane only if you think that USB descriptors can be sane :)

Anyway, this loop will always terminate as we have a finite sized USB
descriptor that this function is parsing.  As to how many times we will
recurse, I don't really know as I haven't spent much time looking into
the different messed up USB audio devices out there on the market...

Sorry I can't be of more help, but I don't think you need to worry about
this function.

thanks,

greg k-h
