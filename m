Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVKLVOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVKLVOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVKLVOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:14:53 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:31478 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964814AbVKLVOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=X6ljq+Twx2U4+Mo5dnFu2TPlAsLj2OZGbZeWPiwOHixYls1ORBFcHeKzPPlKVSVdSwQsW8THIRCry2KsZ49yDnuBlt1kvVWHAzMr7K/12Q1YLS9S2o/lqnheUnU9hSR6D32ELkmYeGD7YxZxvDWV05xLJul4xX3taiwzJH2uCtE=
Date: Sun, 13 Nov 2005 00:28:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: PowerBook G4 boot failure (was: Re: Linuv 2.6.15-rc1)
Message-ID: <20051112212829.GC20860@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122145.38409.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511122145.38409.mbuesch@freenet.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 09:45:38PM +0100, Michael Buesch wrote:
> Latest GIT tree does not boot on my G4 PowerBook.
> It freezes after displaying:
>
> Welcome to Linux, kernel 2.6.15-rc1-g44e6f84e
>
> linked at		: 0xc0000000
> frame buffer at	: 0xb8008000  (phys), 0xd000800  (log)
> klimit		: 0xc03f5ae4
> MSR		: 0x00003030
> HID0		: 0x8410c0bc

> This is a 15 inch post feb2005 PowerBook G4.
>
> 2.6.14 properly boots with the same config.

Unless someone else would come up with better idea, you can always do:

	git bisect start
	git bisect bad 44e6f84e3597905816a0440e7218d2ed072120da
	git bisect start 741b2252a5e14d6c60a913c77a6099abe73a854a
		Bisecting: 2021 revisions left to test after this
		[739cafd316235fc55463849e80710f2ca308b9ae] [XFS] fix PBF_NONE handling
	make
		...
		[reboot]
	git bisect good		# if it boots
		or
	git bisect bad		# if it doesn't
	make
		...
		[reboot]

"2021" suggests that it would take 10 or so recompiles to identify bad
commit.

