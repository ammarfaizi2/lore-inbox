Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbSJWK1b>; Wed, 23 Oct 2002 06:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJWK1b>; Wed, 23 Oct 2002 06:27:31 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:56794 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264613AbSJWK13>; Wed, 23 Oct 2002 06:27:29 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.5.44: How to decode call trace
References: <87elai82xb.fsf@goat.bogus.local.suse.lists.linux.kernel>
	<p73isztstim.fsf@oldwotan.suse.de>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Wed, 23 Oct 2002 12:33:25 +0200
Message-ID: <878z0p1m2y.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de> writes:
>> and this is the code:
>> static int __fscap_lookup(struct vfsmount *mnt, struct nameidata *nd)
>> {
>> 	static char name[] = ".capabilities";
>> 	nd->mnt = mntget(mnt);
>> 	nd->dentry = dget(mnt->mnt_sb->s_root);
>> 	nd->flags = 0;
>> 	return path_walk(name, nd);
>> }
>> 
>> What does .text.lock.namei and name.810 mean?
>
> .text.lock.namei means that it hung in the slow path of a spinlock that
> is referenced from namei.c

I guess this is what __down_failed means.

> name.810 is a static data variable, probably the static char name[]
> shown above. Remember the kernel backtrace is not exact and can print
> random stack junk that looks like return addresses too. You always have 
> to sanity check each entry.

Ok, I'll keep that in mind.

>> Is there a way to get the line number out of these hex values?
>
> addr2line -e vmlinux ... does this when you compile the kernel with -g 

Great! This is what I was searching for.

When I build with "make -k EXTRA_CFLAGS=-g EXTRA_LDFLAGS=-g bzImage",
I get a ton of error messages from drivers/acpi/include/actypes.h and
other acpi related stuff, starting with: #error ACPI_MACHINE_WIDTH not
defined. Maybe this is not the usual way to build with -g, but I don't
get these errors with "make -k bzImage". Maybe someone is interested
in this.

Anyway, I come around this by first building with "EXTRA_CFLAGS=-g
EXTRA_LDFLAGS=-g", ignoring the error messages and then a second try
with only EXTRA_LDFLAGS=-g.

Regards, Olaf.
