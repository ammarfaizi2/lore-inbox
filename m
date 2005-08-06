Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVHFQvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVHFQvC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 12:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVHFQvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 12:51:02 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21386 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263254AbVHFQvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 12:51:01 -0400
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: rdunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com>
	<m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>
	<42F4C6E8.1050605@gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 06 Aug 2005 10:50:25 -0600
In-Reply-To: <42F4C6E8.1050605@gmail.com> (Luca Falavigna's message of "Sat,
 06 Aug 2005 14:19:20 +0000")
Message-ID: <m13bpnyppq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna <dktrkranz@gmail.com> writes:

> Eric W. Biederman ha scritto:
>> So without doing passing --real-mode the vga= parameter currently
>> cannot work.  The vga= parameter is processed by vga.S which
>> make BIOS calls and we bypass all of the BIOS calls.
> Actually that file is video.S

Oops.  Anyway I believe you also want to look at include/linux/tty.h
at the screen_info structure.  I believe that is where
all of that information is passed.

>> So you can try with the --real-mode option and you have
>> a chance of the code working.  Or you can figure out which
>> information video.S passes to the kernel figure out how
>> to get that same information out of a running kernel
>> and then /sbin/kexec can be tweaked to pass the current
>> video mode.  Changing frame buffer modes shouldn't work
>> but you should at least be able to preserve the existing
>> ones.
> I tried to pass --real-mode flag to kexec but my virtual machine doesn't like
> it. When I launch kexec -e, it tells me: "A strange behaviour occourred which
> crashed virtual machine". 

Cool.  I haven't used that code in a long time but it is pretty
trivial code to switches to real mode so I don't really doubt it :)

> I'll dig source code ASAP to figure out this matter.
> Meanwhile I'm going to follow your advice to inspect video.S in order to track
> down something useful.

Sounds good.

Eric
