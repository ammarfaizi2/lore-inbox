Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUGDB1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUGDB1a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 21:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbUGDB13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 21:27:29 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:38536 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265311AbUGDB1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 21:27:15 -0400
Date: Sun, 4 Jul 2004 03:27:14 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040704012714.GA28531@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703133556.44b70d60.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 01:35:56PM -0700, Andrew Morton wrote:

> Why is it "extremely bogus"?  I assume Olaf had a reason for wanting chmod
> on procfs files?

On a related note:
ahu@d800:/sys/devices/system/cpu/cpu0/cpufreq$ ls -l
total 0
-r--------    1 ahu      ahu          4096 2004-07-04 03:18 cpuinfo_cur_freq
-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 cpuinfo_max_freq

..

I'm not entirely sure why the current CPU frequency has suddenly become a
state secret, nor why the ownership of these files appears to be uid 1000.

-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 cpuinfo_min_freq
-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_available_frequencies
-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_available_governors
-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_cur_freq
-r--r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_driver
-rw-r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_governor
-rw-r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_max_freq
-rw-r--r--    1 ahu      ahu          4096 2004-07-04 03:18 scaling_min_freq

This appears to be even more bogus - uid 1000 can write to the scaling
governor. It looks like the uid that mounted /sys owns these files. Not
entirely sure what happens.

Fixes appear trivial but I wonder about the reasons.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
