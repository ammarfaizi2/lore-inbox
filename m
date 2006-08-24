Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWHXD7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWHXD7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWHXD7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:59:45 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:28876 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1030262AbWHXD7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:59:45 -0400
Message-ID: <44ED25AE.9030003@student.ltu.se>
Date: Thu, 24 Aug 2006 06:06:06 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andrew Morton <akpm@osdl.org>, Prajakta Gudadhe <pgudadhe@nvidia.com>,
       jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm2] Generic boolean
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com> <20060821224457.65de5111.akpm@osdl.org> <44EB8B2A.8030603@student.ltu.se> <20060822161706.bad04598.akpm@osdl.org> <44EC3878.9070300@student.ltu.se> <Pine.LNX.4.61.0608231403280.14327@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608231403280.14327@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>Hi,
>
>
>  
>
>>There has been concern about adding other values then 0 and 1. There has been
>>ideas to do something like:
>>bool b = i & 1 : 0;
>>    
>>
>
>I think you miseed a '?'
>  
>
Yes, thanks...

>bool b = (i & 1) ? : 0;
>  
>
...but I meant: bool b = i ? 1 : 0;

>  
>
>>/*or*/
>>bool b = !!i;
>>
>>but all that is needed is just a casting:
>>
>>bool b = (bool) i;
>>    
>>
>
>No casting needed (in fact, casting is more evil than !!). If bool is a
>  
>
Please inform me why casting is evil (other then risking losing data, by 
cutting the value). But also, _Bool-casting is after all a bit special 
since it does not seem (at least by me) to be able to get a wrong value 
(giving it a value other then 0 but reciving 0).

>bool, then the compiler will (hopefully) ensure that b will only get
>values valid for bools.
>  
>
No, not really. Because _Bool is a byte and not a bit, you can put in a 
value other then 0 or 1 if you cast the pointer (if you insert 256 it 
becomes 0). But after all, there should not be any:
if (b == true)
in the code anyway, so it should be ok.

>Jan Engelhardt
>  
>
/Richard Knutsson
