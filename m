Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbULVFRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbULVFRQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbULVFRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:17:16 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62619 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261316AbULVFRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:17:12 -0500
Subject: Negative "ios_in_flight" in the 2.4 kernel
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 21:05:36 -0800
Message-Id: <1103691937.23157.14.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at some "iostat" data from a 2.4.26 machine. The
device utilizations are 100 percent, even when the disk is idle, which
is mathematically impossible. By doing some digging, I discovered this
is a kernel bug, caused by "hd->ios_in_flight" going negative. The
relevant code appears to my untrained eyes to be in
drivers/block/ll_rw_blk.c, specifically


static inline void down_ios(struct hd_struct *hd)
{
        disk_round_stats(hd);
        --hd->ios_in_flight;
}

static inline void up_ios(struct hd_struct *hd)
{
        disk_round_stats(hd);
        ++hd->ios_in_flight;
}

Question: wouldn't a simple refusal to decrement ios_in_flight in
"down_ios" if it's zero fix this, or am I missing something?

Ed Borasky
znmeb@cesmail.net

