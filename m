Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755362AbWKRXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbWKRXZR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbWKRXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 18:25:16 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:19357 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1755362AbWKRXZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 18:25:14 -0500
Date: Sun, 19 Nov 2006 00:24:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oleg Verych <olecom@flower.upol.cz>
cc: Folkert van Heusden <folkert@vanheusden.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
In-Reply-To: <20061118215117.GA15686@flower.upol.cz>
Message-ID: <Pine.LNX.4.61.0611190020400.8225@yvahk01.tjqt.qr>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz>
 <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com>
 <20061118023832.GG13827@flower.upol.cz> <Pine.LNX.4.61.0611182029150.10940@yvahk01.tjqt.qr>
 <20061118215117.GA15686@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 18 2006 21:51, Oleg Verych wrote:
>On Sat, Nov 18, 2006 at 08:30:02PM +0100, Jan Engelhardt wrote:
>> >Then, who you think prints that "Killed" or "Segmentation fault"
>> >messages in *stderr*?
>> >[Hint: libc's default signal handler (man 2 signal).]
>> 
>> Please enlighten us on how you plan to catch the uncatchable SIGKILL.
>
>Here's question of getting information. Collecting information is
>possible by `waitpid()' from parent process as Miquel noted.

Yes, that is true. However that would involve adding support for This 
Situation to the parent process. Which is where it becomes tricky. Patch 
/sbin/init, in case the daemon runs like everything else. Or patch 
xinetd, in case it is run from within that. Or, ...
  The 'problem' with the waitpid solution is that you would need to 
patch every possible parent that may become the owner of The Sigkilled 
Target.

>That man above, gave me impression, that SIG_DFL can not be changed in
>case of KILL and STOP signals, what yields to "The signals SIGKILL and
>SIGSTOP cannot be caught or ignored." Implementation of such no-action
>can be different. In case if kernel just stops processing of task with
>STOP, breaks with KILL, without giving a chance to flush any pending data
>OK, if this is an assembler prorgam with just data segment and no
>infrastructure at all. But i think (didn't read anything), it is bad, if
>there's libc with standard stream I/O buffers and no callback is possible.

	-`J'
-- 
