Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263364AbTCSWoQ>; Wed, 19 Mar 2003 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263373AbTCSWoQ>; Wed, 19 Mar 2003 17:44:16 -0500
Received: from spc1.esa.lanl.gov ([128.165.67.191]:17024 "EHLO
	spc1.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S263364AbTCSWoO>; Wed, 19 Mar 2003 17:44:14 -0500
Subject: Re: 2.5.65-mm2
From: "Steven P. Cole" <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: jjs <jjs@tmsusa.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E78EC63.9050308@tmsusa.com>
References: <20030319012115.466970fd.akpm@digeo.com>
	 <1048103489.1962.87.camel@spc9.esa.lanl.gov>
	 <20030319121055.685b9b8c.akpm@digeo.com>
	 <1048107434.1743.12.camel@spc1.esa.lanl.gov>
	 <1048111359.1807.13.camel@spc1.esa.lanl.gov>  <3E78EC63.9050308@tmsusa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048114307.1511.12.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-1mdk 
Date: 19 Mar 2003 15:51:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 15:17, jjs wrote:
> Steven P. Cole wrote:
> 
> >I repeated the tests with 2.5.65-mm2 elevator=deadline and the situation
> >was similar to elevator=as.  Running dbench on ext3, the response to
> >desktop switches and window wiggles was improved over running dbench on
> >reiserfs, but typing in Evolution was subject to long delays with dbench
> >clients greater than 16.
> >
> >I rebooted with 2.5.65-bk and ran dbench on ext3 again.  Everything was
> >going smoothly, excellent interactivity, and then with dbench 28, the
> >system froze.  No response to pings, no response to alt-sysrq-b (after
> >alt-sysrq-s).  A hard reset was required.  Nothing interesting logged.
> >Too bad.  Before it crashed, 2.5.65-bk was responding to typing in an
> >Evolution new message window better than -mm2.
> >
> 
> Just out of curiosity, what is the result of:
> 
> cat /proc/sys/sched/max_timeslice?
> 
> Does setting that to e.g. 50 make -mm2 smooth?
> 
> Joe

[root@spc1 steven]# cat /proc/sys/sched/max_timeslice
200
[root@spc1 steven]# echo 50 >/proc/sys/sched/max_timeslice
[root@spc1 steven]# cat /proc/sys/sched/max_timeslice
50

Ouch. I inserted the above text saved as a file, and had to wait
over a minute after hitting the OK button.  I aborted dbench which was
running 24 clients on ext3 just to finish this.

The change in max_timeslice didn't seem to improve things.

Apart from the little matter of crashing, 2.5-bk was more usable at that
and higher loads.

I'll try the different value of max_timeslice with dbench on reiserfs
next.  That's where the lack of response was most evident.

Steven
