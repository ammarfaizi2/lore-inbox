Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVIDW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVIDW5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVIDW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:57:44 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:29710 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932101AbVIDW5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:57:43 -0400
Message-ID: <431B7BE2.9070806@symas.com>
Date: Sun, 04 Sep 2005 15:57:38 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050829 SeaMonkey/1.1a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6, devfs, SMP, SATA
References: <d2a0e906050903212678ad88a1@mail.gmail.com> <81b0412b0509041529524bca1f@mail.gmail.com>
In-Reply-To: <81b0412b0509041529524bca1f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I replaced the Winchester 3000+ in my Asus A8v-Deluxe with an 
AMD X2 3800+. I had been running a 2.6.12.3 kernel without SMP support. 
After installing the new CPU I booted up with no trouble and 
reconfigured/recompiled with SMP support. However, upon installing this 
kernel, I was unable to boot.

The system's root partition is striped using software raid0, composed of 
two partitions on two separate SATA drives. For some reason the block 
device files for the second drive were not being automatically created 
in /dev, so the array could not be created properly, it only found one 
of the two partitions. After a bunch of screwing around to find out what 
was going on, I finally wound up adding a bunch of explicit mknod 
commands in my initrd's linuxrc, and that fixed the problem.

Of course, the system only stayed up for a minute or less, and then 
crashed with an OOPS. I went back to my uniprocessor kernel, downloaded 
2.6.13, built that with SMP, again found that I needed to insert 
explicit mknod's for the second SATA drive, and finally have a stably 
running system.

So, any guesses why with otherwise identical config options, a kernel 
with SMP enabled doesn't boot up with all of the device nodes that it 
should? (Both drives are on the same controller. I haven't checked to 
see if any other device files are missing.)

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

