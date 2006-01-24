Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWAXX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWAXX14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWAXX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:27:56 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31649 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750830AbWAXX1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:27:55 -0500
Message-ID: <43D6B7F9.3020407@comcast.net>
Date: Tue, 24 Jan 2006 18:27:53 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: poor raid0 performance in 2.6.16-rc1-mm2?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll have to reboot to double check that this is specific to the above 
kernel version, but It seems something is either wrong with my 
particular kernel config for raid0, or my raid0 is setup wrong.

my raid0 uses 64k chunk sizes on an ext3 fs that's 367GB large, (across 
two identical sata disks on nforce4 chipset)

I have partitions on both drives of equal size (2 altogether) that are 
outside of the raid0.  I dbenched those partitions, the raid0 device, 
and libata pata devices i also have (same rpm, less cache, same company).  

pata disk : 403MB/sec
sata disk 1: 446MB/sec
raid0 : between 336MB/sec and 386MB/sec

now the sata disks alone, get 446MB/sec, but the raid device that's 
comprised of them is getting >60MB/sec less throughput. 

This difference is much more drastic when say only 1 process is used 
with dbench,

sata disk 1: 230MB/sec
raid0 : 96MB/sec


Something definitely feels wrong with these numbers. 

All filesystems are ext3, on an athlon 64 x2 system, during each test no 
other io was performed, there is no swap and no other cpu intensive 
operations were going on. 

the filesystems were all created the same way, and all have the same 
blocksizes and such.  All are mounted with default options too. 
