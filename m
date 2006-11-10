Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932843AbWKJKnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbWKJKnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWKJKnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:43:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:40501 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932843AbWKJKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:43:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=j6ptpP+juQJcb3eJKcdXfvgfeiWghSxJAQymfpKf56BnwUnkZ9xF4nKWnobtVaUEVkMEFbZTzA+uH0j/lWc50AFsNugx2rLAfM7RgOSZUiZLVnWVsqiulVPN7n6g1vSdOetTBiAHRkpDqurgxbz8aY1M6OQQa0PqiclhWNfT07s=
Message-ID: <45545803.1040005@innova-card.com>
Date: Fri, 10 Nov 2006 11:44:19 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid
 problem
References: <20061108015452.a2bb40d2.akpm@osdl.org>	<20061108165540.0d3c4340.akpm@osdl.org>	<200611090204.45299.rjw@sisk.pl>	<200611091642.01453.rjw@sisk.pl> <20061109095811.ac654e13.akpm@osdl.org>
In-Reply-To: <20061109095811.ac654e13.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 9 Nov 2006 16:42:00 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>> This indeed is caused by fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch
>> which affects two out of three boxes on which I tested it (both have Radeon cards).
> 
> Thanks, dropped.
> 

Well I'm probably missing something but I really don't see what !

For example, let say that the four first bytes of an image are 0x06,
0xe0, 0x38, 0x00.

If
	bpp = 1
	start_index = 0
	on a little endian platform 
	this patch is _not_ applied

slow_imageblit() will write into the frame buffer the following
bytes: 0x60, 0x07, 0x1c, 0x00 instead of the original ones. The bits
of each bytes have been inversed (bit7->bit0, bit6->bit1, bit5->bit2,
bit4->bit3, bit3->bit4, ...) and that's the reason why _I_ get all
fonts inverted.

With this patch applied, the bytes written into the frame buffer will
be exactly the same as the original ones. Therefore it fixes my
inverted view but broke Rafael's one.

Now, I'm very not familiar with all frame buffer stuff so I must be
missing somthing obvious. If anyone could give me some hints there
that would be nice.

Thanks
		Franck
