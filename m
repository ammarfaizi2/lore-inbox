Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVI3VqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVI3VqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbVI3VqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:46:24 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:40720 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932595AbVI3VqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:46:23 -0400
Date: Fri, 30 Sep 2005 23:46:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
Message-Id: <20050930234643.7a7b06ce.khali@linux-fr.org>
In-Reply-To: <20050928024956.GA24527@vana.vc.cvut.cz>
References: <20050907181415.GA468@vana.vc.cvut.cz>
	<20050907210753.3dbad61b.khali@linux-fr.org>
	<431F4006.6060901@vc.cvut.cz>
	<20050925195735.1ef98b40.khali@linux-fr.org>
	<43371F89.7090704@vc.cvut.cz>
	<20050928024956.GA24527@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

> This patch changes w83627hf and w83627ehf drivers to reserve only ports
> 0x295-0x296, instead of full 0x290-0x297 range.  While some other sensors
> chips respond to all addresses in 0x290-0x297 range, Winbond chips respond
> to 0x295-0x296 only (this behavior is implied by documentation, and matches
> behavior observed on real systems).  This is not problem alone, as no
> BIOS was found to put something at these unused addresses, and sensors
> chip itself provides nothing there as well.
> 
> But in addition to only respond to these two addresses, also BIOS vendors 
> report in their ACPI-PnP structures that there is some resource at I/O 
> address 0x295 of length 2.  And when later this hwmon driver attempts to
> request region with base 0x290/length 8, it fails as one request_region
> cannot span more than one device.
> 
> Due to this we have to ask only for region this hardware really occupies,
> otherwise driver cannot be loaded on systems with ACPI-PnP enabled.
> 
> Signed-off-by:  Petr Vandrovec <vandrove@vc.cvut.cz>

OK, looks good, applied to my local tree. I'll push it to Greg KH in a
week or so. Thanks.

-- 
Jean Delvare
