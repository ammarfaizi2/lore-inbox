Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130773AbQLPGrw>; Sat, 16 Dec 2000 01:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQLPGrn>; Sat, 16 Dec 2000 01:47:43 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:42247 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130472AbQLPGrd>;
	Sat, 16 Dec 2000 01:47:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Gerard Beekmans <gerard@linuxfromscratch.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-test11/12 freezes when copying large amounts of data to loop file system 
In-Reply-To: Your message of "Thu, 14 Dec 2000 14:55:59 CDT."
             <00121414555900.00305@gwaihir> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 17:16:59 +1100
Message-ID: <12757.976947419@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000 14:55:59 -0500, 
Gerard Beekmans <gerard@linuxfromscratch.org> wrote:
>Every time I try to copy a specific directory to a mounted loop file system, 
>Linux freezes up on me. I've tried this several times and it freezes up at 
>the same place every time. When I copy that same directory to a regular file 
>system everything is ok.

Gerard, reporting "kernel freezes" without any diagnostics is not very
useful.  If you apply the kdb patch[*] you will get some diagnostics.

Apply the patch and configure.  Under Kernel debugging, select kdb and
no frame pointers.  If your box is UP, under Processor type select APIC
and IO-APIC support on uniprocessors, then NMI watchdog active for
uniprocessors.  SMP boxes automatically get NMI watchdog.  Recompile,
install, reboot.

When it freezes, after 5 seconds the NMI watchdog will trip and drop
you into kdb.  Issue a 'bt' command to see where it is hanging, send
this trace to the list.  A serial console run to a second machine makes
it a lot easier to capture the trace, otherwise you have to write it
down by hand.

[*] http://oss.sgi.com/projects/kdb/download/ix86/, pick the relevant
patch for your kernel.  You also need a recent modutils from
ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
