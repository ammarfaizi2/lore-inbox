Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWBRSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWBRSou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWBRSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:44:50 -0500
Received: from quechua.inka.de ([193.197.184.2]:10204 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932110AbWBRSot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:44:49 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: How to find the CPU usage of a process
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060218174209.4376.qmail@web32607.mail.mud.yahoo.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FAX4Z-0000zv-00@calista.inka.de>
Date: Sat, 18 Feb 2006 19:44:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Irfan Habib <irfanhab@yahoo.com> wrote:
> I wanted to ask how can I find the cpu usage of a
> process, as opposed to runtime, with cpu usage I mean
> actually how many time slices were awarded to a
> specific process

It is accounted in seconds in usermode and kernelmode (io processing), not
in slicess.

You can use the result wof wait3(2) if you are the parent:

/usr/bin/time -v sleep 3
        Command being timed: "sleep 3"
        User time (seconds): 0.00
        System time (seconds): 0.00
        Percent of CPU this job got: 0%
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:03.00
        Average shared text size (kbytes): 0
        Average unshared data size (kbytes): 0
        Average stack size (kbytes): 0
        Average total size (kbytes): 0
        Maximum resident set size (kbytes): 0
        Average resident set size (kbytes): 0
        Major (requiring I/O) page faults: 0
        Minor (reclaiming a frame) page faults: 175
        Voluntary context switches: 2
        Involuntary context switches: 0
        Swaps: 0
        File system inputs: 0
        File system outputs: 0
        Socket messages sent: 0
        Socket messages received: 0
        Signals delivered: 0
        Page size (bytes): 4096
        Exit status: 0

You could maybe also use BSD Job Accounting.

At runtime, the /proc interface is for you. See libproc for the data you can
query. /usr/include/proc/readroc.h:

    utime,          // stat            user-mode CPU time accumulated by proces 
    stime,          // stat            kernel-mode CPU time accumulated by process

Gruss
Bernd
