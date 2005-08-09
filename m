Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVHIQQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVHIQQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVHIQQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:16:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56047 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964856AbVHIQQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:16:07 -0400
Message-ID: <42F8D6BF.70303@mvista.com>
Date: Tue, 09 Aug 2005 11:15:59 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vernon Mauery <vernux@us.ibm.com>
CC: Rusty Russell <trivial@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: dmi_table counting in ipmi_si_intf.c
References: <1123630997.3246.18.camel@bluecow>
In-Reply-To: <1123630997.3246.18.camel@bluecow>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea why that value was a "1".  However, looking at this, the 
"0" does seem correct; this is a valid patch.

-Corey

Vernon Mauery wrote:

>I am working on getting one of the IBM blades to use ipmi and have run
>into a problem.  The driver doesn't load because it says it can't find
>the device.
>
>dmidecode shows that there are 39 entries and that the last one is the
>BMC.  I looked into dmi_table and noticed that it parses the table by
>length and by number of entries.  But I found that it goes from i=1 to
>i<num.  This causes it to skip the last entry in the table.  Is there a
>reason it is i=1 instead of i=0?  or for that matter i<num instead of
>i<=num?
>
>Ensure that all dmi table entries get parsed.
>
>Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
>---
>
>diff -uar a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>--- a/drivers/char/ipmi/ipmi_si_intf.c	2005-08-09 08:11:41.000000000 -0700
>+++ b/drivers/char/ipmi/ipmi_si_intf.c	2005-08-09 08:12:51.000000000 -0700
>@@ -1690,7 +1690,7 @@ static int dmi_table(u32 base, int len, 
> 	u8 		  __iomem *buf;
> 	struct dmi_header __iomem *dm;
> 	u8 		  __iomem *data;
>-	int 		  i=1;
>+	int 		  i=0;
> 	int		  status=-1;
> 	int               intf_num = 0;
> 
>
>
>  
>

