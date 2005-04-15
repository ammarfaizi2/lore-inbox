Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVDOTki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVDOTki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDOTkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:40:37 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:60110 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261939AbVDOTkM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:40:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ISP7xodvCdSUFTd2Ce8WyZc2ZfhxN6AmJ0Bk0yvrJ7AipH+xMQWIkBCg4dAVEwwHO+E1pPYBbZhyE9zLeIVxrsZZOg8PXhuv8SyIMdoEceOgg62Pr3mEyBYeuyyuwW0x/JDj7cYt1x9kVcIURe8otNvSeiHImLvKh6lAiZ/YBTM=
Message-ID: <e1e1d5f4050415124051ee6f79@mail.gmail.com>
Date: Fri, 15 Apr 2005 12:40:05 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Kernel Rootkits
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1113592915.23839.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17d79880504151115744c47bd@mail.gmail.com>
	 <e1e1d5f40504151140411a3387@mail.gmail.com>
	 <1113592915.23839.6.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-04-15 at 11:40 -0700, Daniel Souza wrote:
> > A way to "protect" system calls is, after boot a trusted kernel image,
> > take a MD5 of the syscalls functions implementations (the opcodes that
> > are part of sys_read for example) and store it in a secure place.
>
> That's the problem, once the kernel is compromised there's no such thing
> as a secure place.  Solving this problem requires things like "trusted
> computing" aka hardware support.

yes, hardware support like a floppy disk or a memory key with the
read-only switch turned on after a sucessful boot storing the
hashes... paranoia that works  =) Or just print them, and when in
doubt if your kernel is patched, take another checksum of system calls
and compare to paper... =)

Ok, kidding apart, there's no way to safely protect the system against
memory patching. Maybe, some hardware lock that will keep a "code
segment block" of kernel memory as read-only and a separated segment
for data (as read-write), and after the boot and kernel load, this
lock is activated by a asm call or something like that. This stills
not functional, to not mention impossible. You can implement ways to
make kernel memory patching harder, like avoid any mechanism that can
give direct access to memory like /dev/mem, or /dev/kmem (or patch
them to avoid access to specific areas, because some applications like
Xorg uses direct memory access with that mechanisms to do they duty.)
In fact, avoid any mechanism that can be used by userspace processes
to read/write memory data above 0xc00000. This will also not avoid
kernelspace exploitation from programming bugs (like recent (?) VMA
problems, and ancient ptrace bugs that could lead to privilege
elevation). It's just a mechanism to help securing a system.

Or just try grsec =)

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
