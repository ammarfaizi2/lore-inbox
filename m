Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbUJ0Glv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbUJ0Glv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUJ0Ggp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:36:45 -0400
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:15236 "EHLO
	two.holviala.com") by vger.kernel.org with ESMTP id S262299AbUJ0GdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:33:05 -0400
Message-ID: <417F411A.4090401@holviala.com>
Date: Wed, 27 Oct 2004 09:32:58 +0300
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
References: <417E0EA8.7000704@holviala.com> <20041026171157.21c7a15a.akpm@osdl.org> <200410261933.50544.dtor_core@ameritech.net> <20041027055059.GB1211@ucw.cz>
In-Reply-To: <20041027055059.GB1211@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>>>This patch limits the scroll wheel movements to be either +1 or -1 on
>>>>the event -> emulated PS/2 level. I chose to implement it there because
>>>>mousedev emulates Microsoft mice but the real ones almoust never return
>>>>a bigger value than 1 (or -1).
>>>>...
>>>>+#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
>>>>+				if (value) { value = (value < 0 ? -1 : 1); }
>>>>+#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
>>>
>>>This is really not a thing which we can put behind compile-time config.
>>>
>>>Can we come up with a fix which works correctly on all hardware?  If not,
>>>this workaround will need to be enabled by some sort of runtime detection.
>>>
>>
>>Unless someone (Vojtech?) has an objection I think we should always have
>>this workaround activated - after all mousedev provides legacy emulation
>>mostly for XFree/XOrg benefit anyway. Clients accessing data through evdev
>>will see the full picture regardless.
> 
>  
> We can have a workaround for XOrg, but not one like this. This will make
> fast scrolling unreliable. I have standard Microsoft-compatible mice
> which do report more than one scroll tick per report, if you scroll the
> wheel fast enough, and this throws away the extra ticks.

It wasn't an optimal solution, but just a quick hack that made the 
scrollpoint usable. BTW, I've tried with about a dozen wheelmice and all 
of them needed real misuse to get a packet where the scroll amount was 
more than 1....

Not that I'm claiming that those kind of mice don't exist. They do, one 
of them is this ScrollPoint that I'm using now.

> We would have to split the value into multiple events which would each
> report a 1 or -1.

That would be the right solution - I thought about it but deciced not to 
steal any more of my employers time.... Besides, I needed to slow the 
wheel/stick action down anyway since a light touch of the stick 
generates insane scroll events. In Windows with the default driver the 
stick operated like Home/End...



Kim

