Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbVBFEZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbVBFEZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 23:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272721AbVBFEZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 23:25:48 -0500
Received: from bl5-232-195.dsl.telepac.pt ([82.154.232.195]:42639 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S266027AbVBFEZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 23:25:36 -0500
Message-ID: <42059C46.1080406@vgertech.com>
Date: Sun, 06 Feb 2005 04:25:42 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Lincoln Dale <ltd@cisco.com>, Ian.Godin@lowrydigital.com,
       linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>	<c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>	<5.1.0.14.2.20050205094038.05323240@171.71.163.14> <20050204150728.6a697e0e.akpm@osdl.org>
In-Reply-To: <20050204150728.6a697e0e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Lincoln Dale <ltd@cisco.com> wrote:
> 
>>sg_dd uses a window into a kernel DMA window.  as such, two of the four 
>>memory acccesses are cut out (1. DMA from HBA to RAM, 2. userspace 
>>accessing data).
>>1.6Gbps / 2 = 800MB/s -- or roughly what Ian was seeing with sg_dd.
> 
> 
> Right.  That's a fancy way of saying "cheating" ;)
> 
> But from the oprofile output it appears to me that there is plenty of CPU
> capacity left over.  Maybe I'm misreading it due to oprofile adding in the
> SMP factor (25% CPU on a 4-way means we've exhausted CPU capacity).

sg_dd is lying or /dev/sg* is broken. Try to do that sg_dd test in any 
single drive and you'll get 20 times the performance you're supposed to 
achieve:

puma:/tmp/dd# time sg_dd if=/dev/sg1 of=/dev/null bs=64k count=1000000 
time=1
Reducing read to 64 blocks per loop
time to transfer data was 69.784784 secs, 939.12 MB/sec
1000000+0 records in
1000000+0 records out

This is a single sata drive. I'm lucky, am I not?  ;-)

Regards,
Nuno Silva

