Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbUJ1Mmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbUJ1Mmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUJ1Mmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:42:53 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:39824 "EHLO
	two.holviala.com") by vger.kernel.org with ESMTP id S262988AbUJ1Mmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:42:47 -0400
Message-ID: <4180E943.8060203@holviala.com>
Date: Thu, 28 Oct 2004 15:42:43 +0300
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kim Holviala <kim@holviala.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
References: <417E0EA8.7000704@holviala.com> <20041026171157.21c7a15a.akpm@osdl.org> <200410261933.50544.dtor_core@ameritech.net> <20041027055059.GB1211@ucw.cz> <417F411A.4090401@holviala.com>
In-Reply-To: <417F411A.4090401@holviala.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:

>>>>> This patch limits the scroll wheel movements to be either +1 or -1 on
>>>>> the event -> emulated PS/2 level. I chose to implement it there 
>>>>> because
>>>>> mousedev emulates Microsoft mice but the real ones almoust never 
>>>>> return
>>>>> a bigger value than 1 (or -1).
>>>>> ...
>>>>> +#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
>>>>> +                if (value) { value = (value < 0 ? -1 : 1); }
>>>>> +#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
>>>>
>>  
>> We can have a workaround for XOrg, but not one like this. This will make
>> fast scrolling unreliable. I have standard Microsoft-compatible mice
>> which do report more than one scroll tick per report, if you scroll the
>> wheel fast enough, and this throws away the extra ticks.

One more comment to the scrollpoint issue: if they haven't fixed it 
after 4.3.something XFree throws away all scroll events where the scroll 
amount is more than 1. So "fast scrolling" is already unreliable, this 
patch just made it work somehow instead of what it's doing now: not 
working at all.



Kim

