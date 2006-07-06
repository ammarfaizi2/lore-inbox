Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWGFSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWGFSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWGFSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:01:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:12307 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030379AbWGFSBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:01:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrCW5QSx315DxE/Wo599UPbR0POoVbDZ3JrjdJVMywjWsiT1/vzayAgAmEzibpOkfLPUzSWaHU+sZ6hzWpIGvddvh9aDEBECFoAihR/QM0c7Dzs1Dcr7YduULjlV+puH9X0kgZnT//W9/8liJxIZsqLQ/nGHX8NQ/PNUmigIlU8=
Message-ID: <cda58cb80607061101l4698f1afr799e9814688903cf@mail.gmail.com>
Date: Thu, 6 Jul 2006 20:01:22 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH 1/1] Only use ARCH_PFN_OFFSET once during boot
Cc: akpm@osdl.org, "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706095103.31772.49822.sendpatchset@skynet.skynet.ie>
	 <44AD1F90.10103@innova-card.com>
	 <Pine.LNX.4.64.0607061556470.3895@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/7/6, Mel Gorman <mel@csn.ul.ie>:
>
> I think my patch does the job of moving ARCH_PFN_OFFSET out of the hot
> path in a less risky fashion. However, if you are sure that callers to
> free_area_init() and ARCH_PFN_OFFSET are ok after your patch, I'd be happy
> to go with it. If you're not sure, I reckon my patch would be the way to
> go.
>

Ok I try to explain better what I have in mind. Your patch changes the
behaviour of free_area_init_node() in the sense that it doesn't work
as expected if its fourth parameter is different from ARCH_PFN_OFFSET,
it even becomes boggus IMHO. And I think it's valid to use it when
FLATMEM model is selected.

I don't know if there is a platform which uses FLATMEM model and do
not setup ARCH_PFN_OFFSET when its memory do not start at 0. But I
don't think we should assume that if FLATMEM model is selected then
all uses of free_area_init_node() imply ARCH_PFN_OFFSET whatever the
value of the fourth parameter. I would say it's a risky implementation
of free_area_init_node() and prone boggus uses of this function.

One example comes in mind, though I don't know if it's possible. Let's
say a platform can't determine where exactly its memory start. It has
to determine this start at boot time, the BIOS may pass it for
example. So in that case you can't use ARCH_PFN_OFFSET and you have to
use free_area_init_node() with a variable as fourth parameter.

-- 
               Franck
