Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKLC1k>; Sat, 11 Nov 2000 21:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129407AbQKLC13>; Sat, 11 Nov 2000 21:27:29 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:38162 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129309AbQKLC1T>;
	Sat, 11 Nov 2000 21:27:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem 
In-Reply-To: Your message of "Sun, 12 Nov 2000 12:32:55 +1100."
             <3A0DF347.43807CB5@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Nov 2000 13:27:13 +1100
Message-ID: <3204.973996033@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2000 12:32:55 +1100, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>> > > NMI Watchdog detected LOCKUP on CPU3, registers:
>That's a pretty wierd trace.  You seem to have addresses related
>to the `apm' kernel thread on mysqld's stack.

Normal unfortunately.  Firstly the ix86 oops code just scans the stack
and prints anything that looks like it might be a kernel address.  It
makes no attempt to confirm that these really are return addresses, so
an ix86 oops trace gets lots of false positives.  Secondly that trace
was converted by klogd (symbols in call trace line instead of numbers)
not by ksymoops, I do not trust the klogd algorithm at all.  Between
the false positives and the very real possibility of klogd having got
it wrong, you have to take any ix86 oops with a pinch of salt.

Statrting klogd as "klogd -x" in /etc/rc.d/init.d/syslog will get rid
of one source of error.  Using the kdb patch[*] will give you a much
better debug environment for NMI lockups.  kdb gives an accurate back
trace because it understands ix86 stack frames as well as the out of
line lock handlers, at the expense of some very ugly code.

[*]ftp://oss.sgi.com/projects/kdb/download/ix86/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
