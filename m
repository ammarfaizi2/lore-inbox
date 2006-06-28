Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWF1QvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWF1QvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWF1QvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:51:16 -0400
Received: from gw.goop.org ([64.81.55.164]:60112 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751384AbWF1QvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:51:15 -0400
Message-ID: <44A2B37F.4030500@goop.org>
Date: Wed, 28 Jun 2006 09:51:11 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: 2.6.17-mm3: segvs in modpost with out-of-tree modules
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing SIGSEGVs in modpost when compiling the out-of-tree madwifi 
driver:

    /bin/sh: line 1: 3701 Segmentation fault scripts/mod/modpost -m -a
    -i /home/jeremy/hg/linux-2.6/Module.symvers -I
    /home/jeremy/svn/madwifi-ng/Modules.symvers -o
    /home/jeremy/svn/madwifi-ng/Modules.symvers vmlinux
    /home/jeremy/svn/madw ifi-ng/ath/ath_hal.o
    /home/jeremy/svn/madwifi-ng/ath/ath_pci.o /home/jeremy/svn/
    madwifi-ng/ath_rate/sample/ath_rate_sample.o
    /home/jeremy/svn/madwifi-ng/net8021 1/wlan.o
    /home/jeremy/svn/madwifi-ng/net80211/wlan_acl.o
    /home/jeremy/svn/madwif i-ng/net80211/wlan_ccmp.o
    /home/jeremy/svn/madwifi-ng/net80211/wlan_scan_ap.o
    /home/jeremy/svn/madwifi-ng/net80211/wlan_scan_sta.o
    /home/jeremy/svn/madwifi-ng/n et80211/wlan_tkip.o
    /home/jeremy/svn/madwifi-ng/net80211/wlan_wep.o /home/jeremy
    /svn/madwifi-ng/net80211/wlan_xauth.o

The backtrace is:

#0  0x4e8017da in strcmp () from /lib/libc.so.6
#1  0x080491a7 in export_no (s=0x0) at modpost.c:209
#2  0x0804b5c3 in read_dump (
    fname=0xbff5fa9d "/home/jeremy/svn/madwifi-ng/Modules.symvers", kernel=0)
    at modpost.c:1312
#3  0x0804b88b in main (argc=21, argv=0xbff5def4) at modpost.c:1390

I haven't really looked at yet, but I was hoping someone had already 
tracked it down.

    J
