Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUGTCfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUGTCfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUGTCfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 22:35:11 -0400
Received: from ozlabs.org ([203.10.76.45]:36997 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265141AbUGTCfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 22:35:06 -0400
Date: Tue, 20 Jul 2004 01:51:10 +1000
From: Anton Blanchard <anton@samba.org>
To: David Eger <eger@havoc.gtf.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
Message-ID: <20040719155110.GA419@krispykreme>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org> <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston> <20040714040403.GA29729@havoc.gtf.org> <20040714233920.GP21856@smtp.west.cox.net> <20040716201515.GA14095@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716201515.GA14095@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Sorry, I tend to think "ppc == pmac".  So, a couple of thoughts:
> 
> (1) Can you make the i8042 disable itself if the hardware isn't there?
>     Those damned bad port messages eat my entire syslog buffer.

We put a quick fix in the ppc64 port. If you pre reserve the i8042 region
then the driver will fail to initialise:

        /*
         * Some machines have an unterminated i8042 so check the device
         * tree and reserve the region if it does not appear. Later on
         * the i8042 code will try and reserve this region and fail.
         */
        if (!(i8042 = of_find_node_by_type(NULL, "8042")))
                request_region(I8042_DATA_REG, 16, "reserved (no i8042)");

Anton
