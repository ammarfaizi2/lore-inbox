Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSDCRzw>; Wed, 3 Apr 2002 12:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312315AbSDCRzn>; Wed, 3 Apr 2002 12:55:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49204 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312302AbSDCRzb>; Wed, 3 Apr 2002 12:55:31 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] kexec aka linux booting linux
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 10:49:05 -0700
Message-ID: <m1bsd0smem.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am in the final stages of polishing up my kexec patches before submitting them
for inclusion in the kernel.  I have come to one last design question.
Currently I am reusing the sys_reboot with a different magic number.
Is this appropriate or do I want to modify the code so it uses it's
own syscall number?

The user space prototype is:
struct kexec_segment {
       void *buf;
       size_t bufsz;
       void *mem;
       size_t memsz;
};

int sys_kexec(void *start, int nr_segments, struct kexec_segment *segments);

For x86 the code places you in 32bit protected mode with paging
disabled.  Giving trivial access to the first 4GB of memory.  All of
the registers are initially zeroed except stack pointer which is
pointed to a location which is good for a few bytes of storage.  The
segment registers are all loaded with flat 32bit segments with a
base address of 0.

For other architectures a similar interface is possible.

After so many changes and so much time I need to clean up and retest
my alpha port.  This is the next step.  That and cleaning up my user
space tools that make use of this.

ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec/
ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec/linux-2.5.7.kexec.diff
ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec/linux-2.5.7.kexec.long
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.7.kexec.diff
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.7.kexec.log

Eric
