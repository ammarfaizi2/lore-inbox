Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUEAS5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUEAS5t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUEAS5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 14:57:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:57050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbUEAS5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 14:57:47 -0400
Date: Sat, 1 May 2004 11:57:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Gerd Knorr <kraxel@bytesex.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: gcc 2.95: cx88 __ucmpdi2 error
In-Reply-To: <jey8oc6lig.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0405011145570.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501112432.GE2541@fs.tum.de>
 <Pine.LNX.4.58.0405011025410.18014@ppc970.osdl.org> <jey8oc6lig.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 May 2004, Andreas Schwab wrote:
> 
> dev->tvnorm->id is __u64.
> 
> linux/videodev2.h:typedef __u64 v4l2_std_id;

Ahh. And maybe this only happens for the "switch()" statement, which would 
explain why gcc-2.95 doesn't have problem with a lot of other 64-bit uses 
in the kernel.

A simple fix might be to just cast it down to a long, since the high bits
seem to be unused. I assume that would fix it. Alternatively, what about
making the "switch()" just be a series of if-statements?

		Linus

