Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312898AbSDEOxi>; Fri, 5 Apr 2002 09:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312916AbSDEOx2>; Fri, 5 Apr 2002 09:53:28 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15378 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312898AbSDEOxS>;
	Fri, 5 Apr 2002 09:53:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "05 Apr 2002 16:37:12 +0200."
             <p73u1qqus87.fsf@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 00:52:57 +1000
Message-ID: <8823.1018018377@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Apr 2002 16:37:12 +0200, 
Andi Kleen <ak@suse.de> wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>> On a smaller config (full config takes too long when single threaded).
>> 
>> kbuild 2.4:
>> 	make oldconfig dep bzImage modules	6:25
>> 	make bzImage modules (no changes)	0:22
>> 
>> kbuild 2.5:
>> 	make oldconfig installable		4:45
>> 	make installable (no changes)		0:16
>
>Hmm, can you explain the two minutes of difference ? Is the old build 
>that inefficient? 

Yes.  kbuild 2.4 invokes a separate copy of make for each directory,
with significant start up overhead.  Plus it runs most directories
twice, once for built in and once for modules, it was the only way to
handle separate flags for kernel and module code.  Rules.make has been
trying to use make as a programming language, but it was never designed
for that.

kbuild 2.5 does a lot of work up front (in C) to build a single, global
makefile which only requires one copy of make and one pass over the
entire kernel.  When the global makefile has been built and the kernel
is already up to date, make runs the global makefile with the entire
kernel dependency tree in sub second time.

BTW, all kbuild 2.5 times so far have been using the unoptimized
pre-processor programs, with all my debugging checks still turned on.

