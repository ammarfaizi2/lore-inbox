Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWBYDbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWBYDbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWBYDbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:31:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20242 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932596AbWBYDba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:31:30 -0500
Date: Sat, 25 Feb 2006 04:31:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a generic implementation
Message-ID: <20060225033118.GF3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +rtc-subsystem-class.patch
>...
>  rtc subsystem rework.   These patches are being updated.
>...

Always building drivers/rtc/utils.o even if no RTC support is enabled 
seems to be a workaround for an issue that should instead be fixed 
properly:

The code in e.g. fs/udf/udftime.c or drivers/scsi/ips.c has some 
overlaps with what you are adding (they are not doing exactly the 
same, but there are overlaps).

We should have one common set of defines/inlines/functions dealing with 
all these time conversion, leap year, length of months/years etc. issues 
instead of adding one more implementation in this area.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

