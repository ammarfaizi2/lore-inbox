Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289024AbSAUDnm>; Sun, 20 Jan 2002 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSAUDnc>; Sun, 20 Jan 2002 22:43:32 -0500
Received: from rj.sgi.com ([204.94.215.100]:20380 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289024AbSAUDnM>;
	Sun, 20 Jan 2002 22:43:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Sun, 20 Jan 2002 18:56:34 -0800."
             <3C4B8362.8B249698@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 14:43:00 +1100
Message-ID: <1032.1011584580@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002 18:56:34 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>I'm not aware of anyone getting kgdb working fully with modules.

kgdb has a script that tells gdb where each module is loaded.  AFAIK it
uses add-symbol-file FILENAME -sSECTION ADDRESS, the __insmod entries
contain enough data to tell gdb what is going on.

>Proper crash analysis needs to know the load address of each module
>at the time of the crash.  We should print them out at Oops time.

You need 13 bits of data per module.  Where each of text, rodata, data
and bss sections were loaded, you cannot assume they are contiguous.
The length of those four sections.  Where the module is on disk, you
cannot assume the object name is the same as the module name, insmod
-o.  The timestamp and kernel version of the module when it was loaded,
to detect updates after the event.  All of that is encoded in the
__insmod entries in /proc/ksyms, 5 lines per module.

>> That is a different problem.  Saying that modular kernels cause
>> problems for debugging is not a good enough reason to deprecate modular
>> kernels, all the problems have been solved.
>
>They are patently *not* solved, because we continue to get a
>stream of partially and competely useless oops reports.

Rule 1.  Users do not read documentation.
Rule 2.  You can't do anything about rule 1.

If you want complete bug reports, write a script that forces the user
to submit all the required data.  Why do I feel the "Linux should have
a bug reporting system" thread starting again?

