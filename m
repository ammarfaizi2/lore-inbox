Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWGaQUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWGaQUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWGaQUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:20:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16795 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030218AbWGaQUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:20:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: <fastboot@osdl.org>
Cc: Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Horms <horms@verge.net.au>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <aec7e5c30606300145p441d8d0xd89fab5e87de5a22@mail.gmail.com>
	<20060705222448.GC992@in.ibm.com>
	<aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com>
	<20060706081520.GB28225@host0.dyn.jankratochvil.net>
	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
Date: Mon, 31 Jul 2006 10:19:04 -0600
In-Reply-To: <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 13 Jul 2006 11:33:51 -0600")
Message-ID: <m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have spent some time and have gotten my relocatable kernel patches
working against the latest kernels.  I intend to push this upstream
shortly.

Could all of the people who care take a look and test this out
to make certain that it doesn't just work on my test box?

My approach is to extend bzImage so that it is an ET_DYN ELF executable
(we have what used to be a bootsector where we can put the header).
Boot loaders are explicitly not expected to process relocations.

The x86_64 kernel is simply built to live at a fixed virtual address
and the boot page tables are relocated.  The i386 kernel is built
to process relocates generated with --embedded-relocs (after vmlinux.lds.S)
has been fixed up to sort out static and dynamic relocations.

Currently there are 33 patches in my tree to do this.

The weirdest symptom I have had so far is that page faults did not
trigger the early exception handler on x86_64 (instead I got a reboot).

The code should be available shortly at:
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/linux-2.6-reloc.git#reloc-v2.6.18-rc3

If all goes well with the testing I will push the patches to Andrew in the next couple 
of days.

Eric
