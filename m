Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbSLOLfB>; Sun, 15 Dec 2002 06:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbSLOLfB>; Sun, 15 Dec 2002 06:35:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:55562 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266379AbSLOLfA>;
	Sun, 15 Dec 2002 06:35:00 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kevin Easton <kevin@sylandro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 st + aic7xxx (Adaptec 19160B) + VIA KT333 repeatable freeze 
In-reply-to: Your message of "Fri, 13 Dec 2002 11:51:27 +1100."
             <20021213115127.A12153@beernut.flames.org.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Dec 2002 22:42:40 +1100
Message-ID: <1047.1039952560@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002 11:51:27 +1100, 
Kevin Easton <kevin@sylandro.com> wrote:
>I'm not sure exactly where this problem fits in, but I'm getting a 
>completely repeatable freeze (100% lockup, no response to keyboard)
>triggered by writing to /dev/st0 (dd if=/dev/urandom of=/dev/st0 bs=512
>count=163840 will reproduce it).
>So... does anyone have any ideas how I should start trying to track this
>down?

Boot with nmi_watchdog=1 (smp) or nmi_watchdog=2 (smp or up), cat
/proc/interrupts to verify that NMI is being used.  If the problem is a
disabled spinloop then the watchdog will trip after 5 seconds and give
you a trace which can be run through ksymoops.  If that trace does not
give enough data to debug the problem, apply the kdb patch[*], read
Documentation/kdb and start digging, bt first and debug from there.

[*] ftp://oss.sgi.com/projects/kdb/download/v2.5/
    kdb-v2.5-2.4.19-common-1.bz2 + kdb-v2.5-2.4.19-i386-1.bz2 or
    kdb-v2.5-2.4.20-common-1.bz2 + kdb-v2.5-2.4.20-i386-1.bz2

