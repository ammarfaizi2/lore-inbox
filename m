Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWDXWWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWDXWWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDXWWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:22:33 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:5806 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751177AbWDXWWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:22:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QCcNd2Wzx+LegQDjwvzG90i2bNg5T0mj2YIJKHL/SVK/pyixH/VL/awEBMR01yDnU21qChGNroC82XViYsy5BBCVW03MClf49jQ9XwoXs09rrFi4oCloM71jeIHvh4HrHYPqrOO8/2a9EFVplSausP6hwHcNaOAhfxgqFNmnnbY=
Message-ID: <444D4FA4.6020604@gmail.com>
Date: Mon, 24 Apr 2006 18:22:28 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
CC: Linux kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, Ted Phelps <phelps@gnusto.com>
Subject: Re: [rfc patch 1/1 -17rc1-mm3] time: add clocksource driver for Geode
 SC-1100  Hi-Res Timer
References: <444CD732.5090703@gmail.com>
In-Reply-To: <444CD732.5090703@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
> Heres a patch (on 17rc1-mm3 + John Stultz's 4/21 fn-renames) that adds
> a new GTOD-clocksource driver for the hires timer in the Geode
> SC-1100.  Ive been running it for most of the last 7 days now, and it
> seems to work well.

Ooof.   Something is broken, causing kernel to 'lock'
No oops, just nothing. 

$ while true; do sleep 30; uptime; done
..
 14:25:23 up  1:09,  2 users,  load average: 0.12, 0.08, 0.01
 14:25:53 up  1:09,  2 users,  load average: 0.07, 0.07, 0.01
 14:26:23 up  1:10,  2 users,  load average: 0.04, 0.06, 0.01
 14:26:53 up  1:10,  2 users,  load average: 0.02, 0.05, 0.00
 14:27:24 up  1:11,  2 users,  load average: 0.07, 0.06, 0.00

then freeze.


Heres the last bit of the syslog:

Apr 24 13:18:24 truck ntpd[1730]: configure: keyword "By" unknown, line 
ignored
Apr 24 13:18:27 truck /usr/sbin/cron[1751]: (CRON) INFO (pidfile fd = 3)
Apr 24 13:18:27 truck /usr/sbin/cron[1752]: (CRON) STARTUP (fork ok)
Apr 24 13:18:28 truck /usr/sbin/cron[1752]: (CRON) INFO (Running @reboot 
jobs)
Apr 24 13:19:17 truck snmpd[1680]: cannot open /proc/net/snmp6 ...
Apr 24 13:21:41 truck ntpd[1730]: synchronized to LOCAL(0), stratum 13
Apr 24 13:21:41 truck ntpd[1730]: kernel time sync disabled 0041
Apr 24 13:22:44 truck ntpd[1730]: synchronized to 64.5.1.130, stratum 2
Apr 24 13:25:59 truck ntpd[1730]: kernel time sync enabled 0001
Apr 24 13:38:02 truck -- MARK --
Apr 24 13:58:02 truck -- MARK --
Apr 24 14:17:01 truck /USR/SBIN/CRON[2015]: (root) CMD (   run-parts 
--report /etc/cron.hourly)[jimc@harpo i2c-stuff]$


Im looking into it, startng with recent presentation tweaks :-/
Ill turn on whatever debug might be relevant, mutex debug included.
This is on an NFSroot setup, not that I suspect it.

Im still interested in feedback,
thanks
Jim Cromie
