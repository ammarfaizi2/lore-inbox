Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACX3L>; Wed, 3 Jan 2001 18:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACX2w>; Wed, 3 Jan 2001 18:28:52 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:3097 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129267AbRACX2l>; Wed, 3 Jan 2001 18:28:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Graham Murray <graham@barnowl.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prelease freezes on serial event 
In-Reply-To: Your message of "03 Jan 2001 21:53:50 -0000."
             <m2n1d8jo9d.fsf@barnowl.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jan 2001 10:28:35 +1100
Message-ID: <19244.978564515@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jan 2001 21:53:50 +0000, 
Graham Murray <graham@barnowl.demon.co.uk> wrote:
>My 2.4.0-prerelease freezes solid on certain serial port events. The
>ones I have seen (and are both repeatable) are when powering off the
>modem and powering it on causes the system to hang solid. Also if an
>incoming call is received on the telephone, the system hangs ( I
>assume that this is when the modem sends 'RING' and asserts the RI
>hardware signal.)

Does your cpu have an APIC?  SMP boxes always do, most non-mobile P6 UP
systems do.  If you have an APIC and assuming it is a software lockup,
install the kdb patch[*].  If your box is UP, under General setup
select APIC for UP then select NMI for UP.  Under Kernel hacking,
select kdb.  You need a recent modutils, see Documentation/Changes.
Ideally you should use a serial console and run a null modem to a
second machine, see Documentation/serial-console.txt.

Boot the kdb enhanced kernel and cat /proc/interrupts to see if NMI is
non-zero.  Only if NMI is non-zero, reproduce the problem.  Five
seconds after the lockup, the NMI watchdog should trip and drop you
into kdb.  The backtrace (bt) command will show where you are hung.
Capture the backtrace on the second machine or hand copy the backtrace,
in either case mail the backtrace to l-k.

[*]ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.7-2.4.0-prerelease.gz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
