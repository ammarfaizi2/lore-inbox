Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264564AbTDPS2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264567AbTDPS2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:28:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264564AbTDPS2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:28:41 -0400
Date: Wed, 16 Apr 2003 11:39:05 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A262@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0304161133110.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Which strikes me as kind of silly since guess who called the ACPI resume
> vector - the BIOS, so why didn't it do whatever stuff then? :) Anyways
> it's not really relevant. The BIOS will never know about add-in cards,
> and my contention is that even these can be woken up properly w/o bios
> repost (after surmounting technical and potential lack-of-documentation
> hurdles, which is why I'd think we would start with an old, ubiquitous,
> thouroughly documented video card as our first guinea pig. Matrox
> Millennium 2, perhaps?)

I completely agree with Andy. We should not re-POST the video hardware, no
matter what. The idea behind ACPI is that the OS takes care of everything, 
including video save/restore. 

We may not have the documentation to properly do that for all hardware 
currently, but that is something that we have to suck up and deal with. 
For now, we go with hardware that we're able to handle. 

The drivers that cannot support reinitialization will not be able to 
support suspend-to-RAM. When we get to a point where it really becomes an 
issue (i.e. after we have decent working code), then we concentrate on 
getting the appropriate docuementation (or code itself, source or binary) 
to do it correctly. 

Trying to figure out if we need to POST or not for different hardware, 
based what the driver knows, is going to become quite a mess real fast. I 
don't want to deal with the pain, and would rather take the high ground, 
even if it means suffering in the short term. 


	-pat

