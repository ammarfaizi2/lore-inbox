Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVBULeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVBULeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 06:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVBULeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 06:34:20 -0500
Received: from d101.x-mailer.de ([212.162.12.2]:51344 "EHLO d101.x-mailer.de")
	by vger.kernel.org with ESMTP id S261950AbVBULeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 06:34:15 -0500
From: "Schwarz" <schwarz@power-netz.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.29: Zombies not detected or removed
Date: Mon, 21 Feb 2005 12:32:33 +0100
Message-ID: <OBECJKACIGIAEGMGGKMPCEIOHJAA.schwarz@power-netz.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
X-Info: valid message
X-Info: original Date
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi everyone,

since 2.4.29 we discovered a strange behaviour.

Severall tasks are no longer detected as destroyed.
means, these tasks have ended but arn't removed from
the processlist.

An example from today:

[root@d102 ]# date
Mon Feb 21 10:14:06 CET 2005
[root@d102 ]# strace -p 33326
attach: ptrace(PTRACE_ATTACH, ...): No such process
[root@d102 ]# ps aux | grep 29579
33326    29579  0.0  0.2 10696 4332 ?        SN   10:11   0:00 -f
/home/ajondoco
root     19168  0.0  0.0  1768  628 pts/0    S    10:15   0:00 grep 29579
[root@d102 ]# strace -p 33326
attach: ptrace(PTRACE_ATTACH, ...): No such process
[root@d102 ]#

As you can see the process in question "29579" was started
10:11 , but as finished its activity already. After 10
minutes it's still not removed from the processlist and 
it's not detected as a zombie. 

the task was an Apache 1.3.3 child over a wrapper calling php
with -f option. 

We think it's unimportant if its forked or execev(),because on
another maschine it was not even an apache invoked. 

Some of the these processes enter zombie state, but were never
fully removed !

Any ideas why it and what happens?


mfG. M.Schwarz
