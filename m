Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318395AbSGaQQL>; Wed, 31 Jul 2002 12:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSGaQQL>; Wed, 31 Jul 2002 12:16:11 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:39871 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318395AbSGaQQK>; Wed, 31 Jul 2002 12:16:10 -0400
Date: Wed, 31 Jul 2002 18:20:17 +0200
From: Michael Schlenstedt <mailinglists_michael@schlenn.net>
To: paulus@samba.org
Cc: ppp-bugs@samba.org, Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [pppd] increasing limit of transfered bytes - kernelbug?
Message-ID: <20020731162017.GA1424@schlenn.net>
Mail-Followup-To: Michael Schlenstedt <mailinglists_michael@schlenn.net>,
	paulus@samba.org, ppp-bugs@samba.anu.edu.au,
	Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: SuSE Linux 8.0 (i386) -- Kernel 2.4.18-4GB
Organization: http://www.schlenn.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all!

I wrote a little script which logs the amount of bytes which were transfered
over a ppp-line (ADSL/PPPoE).

The problem: this only works untill you do not transfer more than 2 GB
(pppd-limit) or 4 GB (kernel-limit).

Within pppd it seems that there is a problem with the $BYTES_RECVD and
$BYTES_SENT variables which can be used in /etc/ppp/ip-up and -down.

PPPD uses "signed int"-counters instead of an "unsigned-int". This is
not a great problem, a patch is attached to this email (thanks to Evgeni
Gechev).

Unfortunately, this only increases the amount of transfered bytes to 4
GB (kernel-limit).

Is there any chance to increase the kernel-limit in feature
kernel-releases?

Bye,
Michael

,----[ pppd patch ]-
| 
| --- main.c      Fri Jan 25 15:03:38 2002
| +++ main.c.etg  Fri Jul  5 00:18:25 2002
| @@ -1090,9 +1090,9 @@
| 
|      slprintf(numbuf, sizeof(numbuf), "%d", link_connect_time);
|      script_setenv("CONNECT_TIME", numbuf, 0);
| -    slprintf(numbuf, sizeof(numbuf), "%d", link_stats.bytes_out);
| +    slprintf(numbuf, sizeof(numbuf), "%u", link_stats.bytes_out);
|      script_setenv("BYTES_SENT", numbuf, 0);
| -    slprintf(numbuf, sizeof(numbuf), "%d", link_stats.bytes_in);
| +    slprintf(numbuf, sizeof(numbuf), "%u", link_stats.bytes_in);
|      script_setenv("BYTES_RCVD", numbuf, 0);
|  }
| 
`----

