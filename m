Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVCJTQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVCJTQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVCJTMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:12:42 -0500
Received: from www.rapidforum.com ([80.237.244.2]:61394 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S262952AbVCJTG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:06:29 -0500
Message-ID: <42309AA9.6040308@rapidforum.com>
Date: Thu, 10 Mar 2005 20:06:17 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>	<422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>	<422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>	<422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>	<422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>	<422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>	<422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com> <20050309211730.24b4fc93.akpm@osdl.org>
In-Reply-To: <20050309211730.24b4fc93.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090003000404090004000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003000404090004000301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached an image here so you can see whats happening. One pixel are 2 seconds. You can see a small 
speed-up before the slow-down. This is where I changed lower_zone_protection from 1024 to 0. So it 
seems its speeding up until the memory is full. Then it drastically slows-down until I set it to 
1024 again. then it goes up slowly but not linear (interesting smoothly) until it peaks again at 82 
MB/Sec.

PS: 82 MB/sec is not our bandwidth-limit. It still peaks there. Dont know why. Certainly not the 
drives. They work up to 200 MB/Sec (10 drives there).

Chris


Andrew Morton wrote:
> Christian Schmid <webmaster@rapidforum.com> wrote:
> 
>> > So, maybe a VM problem?  That would be a good place to focus since
>> > I think we can be fairly certain it isn't a problem in just the
>> > networking code.  Otherwise, my tests would show lower bandwidth.
>>
>> Thanks to your tests I am really sure that its no network-code problem anymore. But what I THINK it 
>> is: The network is allocating buffers dynamically and if the vm doesnt provide that buffers fast 
>> enough, it locks as well.
> 
> 
> Did anyone have a 100-liner which demonstrates this problem?
> 
> The output of `vmstat 1' when the thing starts happening would be interesting.
> 
> 

--------------090003000404090004000301
Content-Type: image/png;
 name="traffic8.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="traffic8.png"

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
QmCC
--------------090003000404090004000301--
