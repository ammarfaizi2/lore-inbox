Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUJZVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUJZVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUJZVDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:03:23 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15765 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261472AbUJZVBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:01:37 -0400
Message-ID: <417EBBB8.3020807@tmr.com>
Date: Tue, 26 Oct 2004 17:03:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] I2C update for 2.6.9
References: <417D4621.5010604@tmr.com><1098231506642@kroah.com> <20041025225459.5ffc37ba.khali@linux-fr.org>
In-Reply-To: <20041025225459.5ffc37ba.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Bill,
> 
> 
>>Greg KH wrote:
> 
> 
> I actually wrote this.
> 
> 
>>>Trip points
>>>===========
>>>
>>>Trip points are now numbered (point1, point2, etc...) instead of
>>>named(_off, _min, _max, _full...). This solves the problem of
>>>various chips having a different number of trip points. The
>>>interface is still chip independent in that it doesn't require
>>>chip-specific knowledge to be used by user-space apps.
>>
>>It would seem that all chips would have off, max, full, etc, but
>>mapping nondescript names into functionality may require some chip
>>info anyway. As you note, with some chips these are not nice linear
>>points on a line, 
>>  so it would seem to tell if the top points were "max norm" and "max 
>>safe" vs. "critical" and "shutdown NOW" is still going to need some 
>>information on the chip, both points and operating range.
> 
> 
> The interface is actually (almost) self-sufficient. A point is the union
> of a temperature and a fan speed. Most often, point1 will have a speed
> of 0, which means it really is _off. point1 will be fan_min. point(P-1)
> will be _max, point(P) will have a speed of 100% and will be _full. The
> advantage of the numbered approach is that you can have has many points
> as the chip provides. It will also help user-space applications, since
> all points can be handled the exact same way, without having to
> interpret the names, know that some names have predefined fan speeds,
> etc.
> 
> The only thing the interface doesn't tell is the shape of the curve
> resulting from the various trip points. This is admittedly chip
> dependent. I think it would be next to impossible to export this through
> sysfs, and I'm not sure it would be worth the pain anyway. The exact
> shape of the curve isn't that important IMHO.
> 
> Your objection about "critical", "shutdown NOW" etc if out of the scope
> of this interface. The critical limits are defined by tempN_crit files.
> Actions taken by the chip when the limit is crossed is admittedly
> chip-dependent. Not a big deal either, since in most cases this is
> either not configurable or motherboard-dependent and set by the BIOS for
> us anyway.
> 
> I hope I answered your question-which-was-not-really-one. :)
> 
You have definitely given me a lot more information, and I do understand 
why you do it this way. The shape of the curve may be of interest I 
would think, if point3 to point4 is 30C to 40C I'm in a normal chip 
range. If they represent 40c to 85C I really worry about flames coming 
out next. That clearly can be known in the application as well, but it 
isn't as easy to to as having names like max_norm, etc.

Anyway, thinks for the expanded info, more than I expected from a 
non-question.

BTW: I see that the new G5 dual-CPU Mac does run the CPUs at 85C, liquid 
cooled. At least ComputerWorld says they do. Yikes!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
