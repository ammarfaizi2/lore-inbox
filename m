Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHYWYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHYWYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUHYWXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:23:34 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:52460 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265943AbUHYWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:18:29 -0400
Date: Wed, 25 Aug 2004 23:18:14 +0100
From: Dave Jones <davej@redhat.com>
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bizarre 2.6.8.1 /sys permissions
Message-ID: <20040825221814.GA20283@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dan Hollis <goemon@anime.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408251319070.4007-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408251319070.4007-100000@sasami.anime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 01:25:12PM -0700, Dan Hollis wrote:


 > Do these file permissions make sense to anyone?

Yes.

 > $ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
 > cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission denied

Reading this file causes reads from hardware on some cpufreq drivers.
This can be a slow operation, so a user could degrade system performance
for everyone else by repeatedly cat'ing it.

 > $ cat /proc/cpuinfo
 > processor       : 0
 > vendor_id       : GenuineIntel
 > cpu family      : 15
 > model           : 2
 > model name      : Intel(R) Celeron(R) CPU 2.60GHz
 > stepping        : 9
 > cpu MHz         : 324.528

This is read from the cpu_khz variable, so isn't affected by
this problem.

 > $ ls -la /sys/devices/system/cpu/cpu0/cpufreq/
 > total 0
 > drwxr-xr-x  2 root root    0 Aug 23 13:06 .
 > drwxr-xr-x  3 root root    0 Aug 23 13:06 ..
 > -r--------  1 root root 4096 Aug 23 13:06 cpuinfo_cur_freq
 > -r--r--r--  1 root root 4096 Aug 23 13:06 cpuinfo_max_freq
 > -r--r--r--  1 root root 4096 Aug 23 13:06 cpuinfo_min_freq
 > -r--r--r--  1 root root 4096 Aug 23 13:06 scaling_available_frequencies
 > -r--r--r--  1 root root 4096 Aug 23 13:06 scaling_available_governors
 > -r--r--r--  1 root root 4096 Aug 23 13:06 scaling_cur_freq
 > -r--r--r--  1 root root 4096 Aug 23 13:06 scaling_driver
 > -rw-r--r--  1 root root    0 Aug 25 13:19 scaling_governor
 > -rw-r--r--  1 root root 4096 Aug 23 13:06 scaling_max_freq
 > -rw-r--r--  1 root root 4096 Aug 23 13:06 scaling_min_freq
 > -rw-r--r--  1 root root    0 Aug 25 13:19 scaling_setspeed

Looks fine to me.

		Dave

