Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWBYNK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWBYNK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWBYNK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:10:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38661 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932714AbWBYNK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:10:26 -0500
Date: Sat, 25 Feb 2006 14:10:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a generic implementation
Message-ID: <20060225131025.GK3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <20060225033118.GF3674@stusta.de> <20060225054619.149db264@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225054619.149db264@inspiron>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:46:19AM +0100, Alessandro Zummo wrote:
> On Sat, 25 Feb 2006 04:31:18 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Always building drivers/rtc/utils.o even if no RTC support is enabled 
> > seems to be a workaround for an issue that should instead be fixed 
> > properly:
> > 
> > The code in e.g. fs/udf/udftime.c or drivers/scsi/ips.c has some 
> > overlaps with what you are adding (they are not doing exactly the 
> > same, but there are overlaps).
> > 
> > We should have one common set of defines/inlines/functions dealing with 
> > all these time conversion, leap year, length of months/years etc. issues 
> > instead of adding one more implementation in this area.
> 
>  I agree. My idea was to place those routines in utils.o and then
>  modify callers, like udftime.c and ips.c to use them. What is currently
>  in utils.c has been gathered from files that were known to me,
>  lice rtctime.c in the arm arch and some rtc drivers. Once deployed,
>  it will be easier to find and convert similar routines.y

Sounds good, but for generic functions, two adjustments are required:
- move the code to lib/
- remove rtc_ prefixes from the functions

>  Best regards,
>  Alessandro Zummo,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

