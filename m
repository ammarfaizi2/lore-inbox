Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVBZXpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVBZXpU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVBZXpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:45:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:54729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261296AbVBZXpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:45:15 -0500
Date: Sat, 26 Feb 2005 15:46:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <16929.1350.119511.746325@hertz.ikp.physik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0502261543190.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
 <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
 <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
 <Pine.LNX.4.58.0502261433431.25732@ppc970.osdl.org>
 <16929.1350.119511.746325@hertz.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Feb 2005, Uwe Bonnes wrote:
>
> /dev/sda4         3512348     6003585   698791990+   0  Empty
> Partition 4 has different physical/logical beginnings (non-Linux?):
>      phys=(0, 0, 0) logical=(3512347, 6, 16)
> Partition 4 has different physical/logical endings:
>      phys=(0, 0, 0) logical=(6003584, 7, 6)
> Partition 4 does not end on cylinder boundary.

Yeah, your case could check for zero in the physical sector stuff too, but 
I'm not sure that matters, since nobody really cares about the physical 
values and they've long been too limited to matter. So I'm not at all 
convinced that adding a few more checks for zero would be any better than 
checking the one zero that Andries does.

I think Andries' patch is fine. We should probably do the same for the 
extended partition case, just to be consistent.

		Linus
