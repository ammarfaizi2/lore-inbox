Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTDZQqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDZQqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:46:19 -0400
Received: from d101.x-mailer.de ([212.162.12.2]:17894 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id S261893AbTDZQqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:46:17 -0400
From: Andreas Gietl <Listen@e-admin.de>
Organization: e-admin internet gmbh
To: Bernhard Kaindl <kaindl@telering.at>
Subject: Re: [PATCH][2.4-rc1] fix side effects of the kmod/ptrace secfix
Date: Sat, 26 Apr 2003 18:58:28 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304250037.45133.Listen@e-admin.de> <200304251640.22021.Listen@e-admin.de> <Pine.LNX.4.53.0304251607540.26723@hase.a11.local>
In-Reply-To: <Pine.LNX.4.53.0304251607540.26723@hase.a11.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304261858.28698.Listen@e-admin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 April 2003 16:30, Bernhard Kaindl wrote:

looks like the shutdown problem was not due to a ptrace-problem, but to a 
IDE-Bug in the ac1-patch:

Hi!

Here is a first test report for 2.4.21-rc1-ac2:

*) Shutdown/Reboot problems in 2.4.21-rc1-ac1 due to
   deadlock in ide_unregister_subdriver() seem to be
   fixed!


rc1-ac2 fixed my shutdown problem.

thanx for the support

> On Fri, 25 Apr 2003, Andreas Gietl wrote:
> > it shows:
> >   PID TTY      STAT   TIME COMMAND
> >  2092 ttyp0    S      0:00 su guest -c ps $PPID;wc -m
> > </proc/$PPID/cmdline 0
>
> Ah ok, I tested this with LC_CTYPE=de_DE.UTF-8, in this case wc has
> to read the contents of the file. When a single-byte locale is used,
> wc just does fstat64() to get the file size(which returns 0 for the file).
>
> > but cat shows:
> > su guest -c 'ps $PPID; cat /proc/$PPID/cmdline'
> >   PID TTY      STAT   TIME COMMAND
> >  2144 ttyp0    S      0:00 su guest -c ps $PPID; cat /proc/$PPID/cmdline
> > suguest-cps $PPID; cat /proc/$PPID/cmdline
> >
> > what happened?
>
> This is ok, access_proces_vm() is working.
>
> > > [pid  2599] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
> > > [pid  2599] write(1, "\n", 1
> >
> > it shows:
> > localhost root # strace -fewrite su -c /bin/echo 2>&1 | grep pid
> > [pid  2159] write(1, "\n", 1
>
> Looks ok also, the task->mm->dumpable check is removed from
> prace_check_attach
>
> > Looks like my results are slightly diffent, Does this mean i did not
> > apply the patch correctly? I applied it twice manually, because patch did
> > not succeed
>
> The above shows that at least the two-liner task_dumpable diff is applied.
>
> > and compiled the kernel 3 times...
>
> Sorry for the different output, I should have made my tests safer against
> system variants. It should have applied clean, maybe some white space issue
> or so, I'll check it. shutdown didn't change? What does it on your system?
>
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
e-admin internet gmbh
Andreas Gietl                                            tel +49 941 3810884
Ludwig-Thoma-Strasse 35                      fax +49 89 244329104
93051 Regensburg                                  mobil +49 171 6070008

PGP/GPG-Key unter http://www.e-admin.de/gpg.html




