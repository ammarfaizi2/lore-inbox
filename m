Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVFNSYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVFNSYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVFNSYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:24:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9623 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261284AbVFNSYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:24:25 -0400
Message-ID: <42AF2088.3090605@sgi.com>
Date: Tue, 14 Jun 2005 14:23:04 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lord <lord@xfs.org>
CC: "K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
       pozsy@uhulinux.hu, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org>
In-Reply-To: <42AF165E.1020702@xfs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colleagues,

(Copied and edited from a post I made on linux-hotplug-devel last month.)

I've privately emailed Steve with a quick-and-dirty solution for the problems he 
was experiencing with the system boot.  I wasn't sure if he was having the same 
problems I've had with 2.6.12 and old packages but it looks like he was.

I'm surprised we haven't had more people on this list wondering about the 
strange behaviour of their initrd/initramfs :) .

When I looked at the original output Steve had posted I noticed that it looked 
like drivers were attempting to load at the same time and because of this he 
eventually hit an oops.  I (and an engineer from another company working on 
another arch) have hit the same problem due to the requirements of our current work.

(Unfortunately, I'm more familiar with RedHat/Fedora than I am with other 
distro's -- please bear with me.)

The issue is that David Howells posted a patch that changed the behaviour of 
kallsyms/insmod/rmmod sometime ago.  The patch *is correct* in what it does, 
however, the patch requires that /sbin/sh must be aware of pid returns by wait().

     http://lkml.org/lkml/2005/1/17/132

There are two fixes that I'm aware of, and depending on what you're doing they 
are both "correct" (although in the case of developing in 2.6.12, IMO, you
_must_ do the latter).

The first fix is for the situation where you're developing for a specific 
distribution.  If this is the case, then you should back out the patch above and 
continue moving forward.

The second fix, and again you must do this if you're developing 2.6.12, is to 
*update the mkinitrd package* which has a new version of /bin/sh.

P.
