Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWCFTMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWCFTMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWCFTMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:12:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51405 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932327AbWCFTMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:12:08 -0500
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>
	<m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com> <440C363F.8000503@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Mar 2006 12:11:50 -0700
In-Reply-To: <440C363F.8000503@suse.de> (Gerd Hoffmann's message of "Mon, 06
 Mar 2006 14:16:47 +0100")
Message-ID: <m1r75f8k21.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann <kraxel@suse.de> writes:

> Eric W. Biederman wrote:
>> 
>> We load the kernel at physical addresses and we enter
>> the kernel at a physical address.  Even the entry point
>> expects that.
>> 
>> Is there some reason you think the entry point is virtual?
>
> Elf specs say so.  The paragraph in question mentions processes not OS
> kernels though ...

The ELF spec only defines how ELF is interpreted for processes running under
an OS if I remember correctly.  Stand-alone executable that run without an
OS (like an OS kernel) play be slightly different rules, and I don't know if
anyone has ever formalized them.  As a consequence those rules like vary
between bootloaders and between architectures.

Currently my assumptions are:

Standalone executables load at the physical not the virtual addresses.
Standalone executables start executing at a physical address and not at
a virtual address.

In most cases virtual==physical in ELF binaries.  Which if you are throwing
something quick together means they will work in either circumstance.  Also
it is unfortunate that ld currently emits relocations for absolute symbols
in ET_DYN executables.

Of practical consequence currently /sbin/kexec makes the assumptions I have
outlined above.  So if you change that you not be able to boot vmlinx with
/sbin/kexec.

Eric
