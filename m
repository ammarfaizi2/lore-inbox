Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWAGMsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWAGMsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWAGMsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:48:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44753 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030432AbWAGMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:48:07 -0500
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@muc.de>, ebiederm@xmission.com,
       Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
	<86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
	<86802c440601062238r1b304cd4j2d9c8e14a8324618@mail.gmail.com>
	<86802c440601062320r597d6970i3b120ec90f96abce@mail.gmail.com>
	<86802c440601070143v44ee9f4dua2dcef2a536d4c73@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 07 Jan 2006 05:46:51 -0700
In-Reply-To: <86802c440601070143v44ee9f4dua2dcef2a536d4c73@mail.gmail.com> (yhlu.kernel@gmail.com's
 message of "Sat, 7 Jan 2006 01:43:22 -0800")
Message-ID: <m1ek3k2ojo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> andi,
>
> In LinuxBIOS, we don't set the MPS 0x467 and the AP still can be started by BSP.
>
> are these really needed for x86_64?
>
>         Dprintk("Setting warm reset code and vector.\n");
>
>         CMOS_WRITE(0xa, 0xf);
>         local_flush_tlb();
>         Dprintk("1.\n");
>         *((volatile unsigned short *) phys_to_virt(0x469)) = start_rip >> 4;
>         Dprintk("2.\n");
>         *((volatile unsigned short *) phys_to_virt(0x467)) = start_rip & 0xf;
>         Dprintk("3.\n");
>
> the STARTUP IPI should work well with MPS v1.4

There are very large x86 machines that a reset is sent to the remote
cpu and thus 0x40:0x67 and 0x40:0x67 becomes relevant.

YH you didn't do something foolish and put a linuxbios table below
0x500 did you?

Eric
