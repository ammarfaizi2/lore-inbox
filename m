Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132891AbRDXITv>; Tue, 24 Apr 2001 04:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132894AbRDXITc>; Tue, 24 Apr 2001 04:19:32 -0400
Received: from passat.ndh.net ([195.94.90.26]:22412 "EHLO passat.ndh.net")
	by vger.kernel.org with ESMTP id <S132891AbRDXITU>;
	Tue, 24 Apr 2001 04:19:20 -0400
Date: Tue, 24 Apr 2001 10:19:15 +0200
From: Alex Riesen <a.riesen@traian.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: broken_apm_power in dmi_scan.c - no return value
Message-ID: <20010424101915.A5368@traian.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, dear lkml,

The mentioned function doesn't return any value, but the calling
code (dmi_check_black_list) depend on it:

static __init int broken_apm_power(struct dmi_blacklist *d)
{
	apm_info.get_power_status_broken = 1;
	printk(KERN_WARNING "BIOS strings suggest APM bugs, disabling power status reporting.\n");
    return 0; /* continue scan  */
}

In dmi_check_blacklist:
		
		if(d->callback(d)) /* callback is a pointer on a function, like broken_apm_power */
			return;

Alex Riesen

