Return-Path: <linux-kernel-owner+w=401wt.eu-S932391AbWLNRLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWLNRLj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932863AbWLNRLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:11:39 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37874 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391AbWLNRLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:11:38 -0500
Date: Thu, 14 Dec 2006 18:11:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Forrest <forrest@lmcg.wisc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Processes with hidden PID files in /proc
In-Reply-To: <20061213180801.A16952@yoda.lmcg.wisc.edu>
Message-ID: <Pine.LNX.4.61.0612141809300.12730@yvahk01.tjqt.qr>
References: <20061213180801.A16952@yoda.lmcg.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Yesterday I discovered some processes that had a PPID which was not
>shown as a running process by "ps".  Also an "ls /proc" did not show
>that PPID.
>
>I've Googled on this enough to find out that these are Linux threads,
>that "ps -m" will show them, that "ls -a /proc" will show /proc/.PPID,
>etc, but I'm still wondering what exact sequence of system calls will
>create a process like this?

It's all there:

18:10 ichi:/proc/3689 # l exe
lrwxrwxrwx 1 root root 0 Dec 14 08:02 exe -> /usr/sbin/named
18:10 ichi:/proc/3689 # l task
total 0
dr-xr-xr-x 6 named named 0 Dec 14 18:09 .
dr-xr-xr-x 5 named named 0 Dec 14 08:02 ..
dr-xr-xr-x 4 named named 0 Dec 14 18:09 3689
dr-xr-xr-x 4 named named 0 Dec 14 18:09 3690
dr-xr-xr-x 4 named named 0 Dec 14 18:09 3691
dr-xr-xr-x 4 named named 0 Dec 14 18:09 3692
18:10 ichi:/proc/3689 # l -d ../3692
dr-xr-xr-x 5 named named 0 Dec 14 18:09 ../3692
18:10 ichi:/proc/3689 # l .. | grep 3692

W.W.W.W.W.

Only "processes" are returned by readdir() on /proc, but every "thread" 
(LWP) is still accessible.

	-`J'
-- 
