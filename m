Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314561AbSDTFTb>; Sat, 20 Apr 2002 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314562AbSDTFTa>; Sat, 20 Apr 2002 01:19:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:4613 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314561AbSDTFT3>;
	Sat, 20 Apr 2002 01:19:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randal, Phil" <prandal@herefordshire.gov.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "Fri, 19 Apr 2002 12:38:05 +0100."
             <AFE36742FF57D411862500508BDE8DD004639E64@cordelia.herefordshire.gov.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Apr 2002 15:19:15 +1000
Message-ID: <16167.1019279955@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002 12:38:05 +0100, 
"Randal, Phil" <prandal@herefordshire.gov.uk> wrote:
>This variation on Quicksort seems superior...  Must look at the libc
>sources someday to see how it does it...
>http://www.neubert.net/Flapaper/9802n.htm

It requires extra storage which is unacceptable.  The kernel tables
must be sorted before any code that might take an exception is used.
The sort must be done very early, before kernel memory management is
setup.  In addition, the kernel stack has a limited size.

If the extra data size depends on the number of elements to be sorted
(flashsort1 needs 0.1n extra data) then it cannot be used for this
task.  Sooner or later the extra data size will blow the limited kernel
storage at boot time.  For this task, the sort must use a small and
fixed amount of extra storage.

You realize that we have probably spent more time discussing the sort
algorithm than can be saved by rewriting the sort?  The sort is invoked
once per boot on tables that are almost sorted already, any savings
will be in milliseconds and do not justify the extra programming
effort.  I will use arch/ppc/mm/extable.c::sort_ex_table() instead of
bubble, anything beyond that is a waste of programming time.

