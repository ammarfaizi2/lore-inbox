Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRLVXTF>; Sat, 22 Dec 2001 18:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282968AbRLVXSp>; Sat, 22 Dec 2001 18:18:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:54792 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282963AbRLVXSh>;
	Sat, 22 Dec 2001 18:18:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Sat, 22 Dec 2001 14:01:26 CDT."
             <20011222140126.B19442@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 10:18:26 +1100
Message-ID: <17322.1009063106@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 14:01:26 -0500, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>On Sat, Dec 22, 2001 at 10:28:55PM +1100, Keith Owens wrote:
>> The patch below dynamically assigns a syscall number to a name and
>> exports the number and name via /proc.  Dynamic assignment removes the
>> collision problem.  Exporting via /proc allows user space code to
>> automatically find out what the syscall number is this week.  strace
>> could read the /proc output to print the syscall name, although it
>> still cannot print the arguments.
>
>Doesn't work.  You've still got problems running binaries compiled against 
>newer kernels (say, glibc supporting a new syscall) against the dynamic 
>syscall.  Numbers don't work, plain and simple.

You did not read my mail all the way through, did you?  I said -

If the [user space] code cannot open /proc/dynamic_syscalls or cannot
find the desired syscall name, fall back to the assigned syscall number
(if any) or fail if there is no assigned syscall number.  By falling
back to the assigned syscall number, new versions of the user space
code are backwards compatible, on older kernels it will use the dynamic
syscall number, on newer kernels it will use the assigned number.

