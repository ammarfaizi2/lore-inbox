Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJMAo7>; Sat, 12 Oct 2002 20:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261389AbSJMAo7>; Sat, 12 Oct 2002 20:44:59 -0400
Received: from fastmail.fm ([209.61.183.86]:11948 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S261387AbSJMAo6>;
	Sat, 12 Oct 2002 20:44:58 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034470239
X-Sasl-enc: tusc/LGjwZJtEspmNlFp0g
Message-ID: <10b901c27252$60199810$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <Pine.LNX.4.33.0210121605490.16179-100000@coffee.psychology.mcmaster.ca>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sun, 13 Oct 2002 10:49:18 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> but that load of 21 is really just an artifact of a bunch
> of procs being in short-term io wait (D state in top/ps), right?
> such procs get counted in loadaverage, even though they're asleep,
> not eating cycles.

Well I tried running this:

while true; do uptime; ps -wax | grep -v ' S' | grep -v 'ps -wax'; sleep 5;
done

Which should show all procs not in the sleep state (except the ps process
itself) every 5 seconds, along with an uptime load. See output below, which
again has a load jump about half way down. It appears no extra processes are
in the 'D' state. And no extra CPU load appears either during the spike.

  7:45pm  up 1 day, 18:06,  2 users,  load average: 0.29, 0.67, 2.11
  7:45pm  up 1 day, 18:07,  2 users,  load average: 0.27, 0.66, 2.10
19784 ?        R      0:00 /usr/local/apache/bin/httpd
  7:45pm  up 1 day, 18:07,  2 users,  load average: 0.24, 0.65, 2.09
19808 ?        R      0:00 /usr/local/apache/bin/httpd
  7:45pm  up 1 day, 18:07,  2 users,  load average: 0.22, 0.64, 2.08
  7:45pm  up 1 day, 18:07,  2 users,  load average: 0.21, 0.63, 2.07
  7:45pm  up 1 day, 18:07,  2 users,  load average: 27.65, 6.46, 3.95
  7:45pm  up 1 day, 18:07,  2 users,  load average: 25.44, 6.35, 3.93
  7:45pm  up 1 day, 18:07,  2 users,  load average: 23.40, 6.25, 3.90
19668 ?        R      0:00 imapd
19669 ?        R      0:00 imapd
19742 ?        D      0:00 imapd
  7:45pm  up 1 day, 18:07,  2 users,  load average: 21.53, 6.14, 3.88
19784 ?        R      0:01 /usr/local/apache/bin/httpd
  7:45pm  up 1 day, 18:07,  2 users,  load average: 19.80, 6.04, 3.86
  7:45pm  up 1 day, 18:07,  2 users,  load average: 18.22, 5.94, 3.84


I did notice a very small load jump earlier caused by what you describe
above, which seems to be due to the journal being flushed, but notice how
small this jump is in comparison to the one above...


  7:38pm  up 1 day, 18:00,  2 users,  load average: 0.63, 1.47, 2.97
  7:39pm  up 1 day, 18:00,  2 users,  load average: 0.58, 1.45, 2.96
18564 ?        D      0:00 imapd
  7:39pm  up 1 day, 18:00,  2 users,  load average: 0.53, 1.42, 2.94
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.49, 1.40, 2.93
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.53, 1.39, 2.92
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.76, 1.41, 2.91
 1441 ?        D      1:23 qmgr -l -t fifo -u
  7:39pm  up 1 day, 18:01,  2 users,  load average: 1.26, 1.50, 2.93
   10 ?        DW    17:08 [kjournald]
 1577 ?        D      0:00 imapd
16346 ?        D      0:00 lmtpd -a
16393 ?        D      0:00 imapd
16427 ?        D      0:00 lmtpd -a
17349 ?        D      0:00 imapd
17481 ?        D      0:00 lmtpd -a
18356 ?        D      0:00 imapd
  7:39pm  up 1 day, 18:01,  2 users,  load average: 1.16, 1.48, 2.91
  465 ?        R      5:57 syslogd -m 0
  7:39pm  up 1 day, 18:01,  2 users,  load average: 1.07, 1.45, 2.89
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.98, 1.43, 2.88
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.98, 1.42, 2.87
  7:39pm  up 1 day, 18:01,  2 users,  load average: 0.90, 1.40, 2.85
  7:40pm  up 1 day, 18:01,  2 users,  load average: 0.99, 1.41, 2.85
1

Now I'm more confused than ever, because there don't actually appear to be
any blocked processes at all? What is going on???

Rob Mueller

