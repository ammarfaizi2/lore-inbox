Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUGJASN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUGJASN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUGJASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:18:13 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:1948 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S265119AbUGJAR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:17:56 -0400
Message-ID: <40EF3637.4090105@am.sony.com>
Date: Fri, 09 Jul 2004 17:20:07 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: linux kernel <linux-kernel@vger.kernel.org>,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com> <20040709193528.A23508@mail.kroptech.com>
In-Reply-To: <20040709193528.A23508@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Here's an alternate patch (compile tested only) which is slightly
> simpler, slightly more flexible, and fixes a small bug in the original.

These are great improvements.  Thanks.

> The simplification centers around removing USE_PRESET_LPJ and
> interpeting a preset value of 0 as a signal to autodetect. This 
> eliminates ifdefs in the code and avoids giving magic significance 
> to the loops_per_jiffy LSb.
Yeah.  When I originally wrote it, I thought using the LSb was cute,
and avoided an extra variable.  Your way is simpler and provides
the extra feature of disabling the preset from the command line.
This, and the elimination of ifdefs is quite nice.

> Additionally, the user can always disable
> the preset by using "lpj=0" which would allow booting a kernel that
> crashes due to a bogus preset. The only problem I can think of with
> this approach is if there is a system out there so slow that lpj=0 is
> actually a valid setting.
It's hard to imagine this case, but that would merely result in
a calibration, right?  For a machine that slow, calibrating the
delay is the least of their worries. :-)

> 
> The final change is to fix a small bug in the original patch:
> loops_per_jiffy was no longer initialized each time calibrate_delay()
> was invoked. This is potentially an issue on SMP systems since
> calibrate_delay() will be invoked for each CPU. One related thing to
> keep in mind is that on an SMP system, using an lpj preset will result
> in the same lpj setting on each CPU. On sane systems this shouldn't be
> a problem, but if there's a machine out there with unequal CPUs it will
> be a problem. Perhaps this is worth mentioning in the help text as well.
I hadn't considered this.  (Too much "embedded" on the brain.)
By help text, do you mean the config text, or something on the wiki page,
or some other file (in Documentation?).

On the subject of help text, is there a Documentation file I should modify
or someone I should notify about the addition of a new kernel command line
option?

> 
> While we're on the topic: Should FASTBOOT perhaps depend on EMBEDDED? I
> can imagine a user with a massively MP system perhaps finding this
> option useful, so maybe not.

I had it there originally, then changed my mind.  I know some server
guys are interested in fastboot.  This particular change might not
be that interesting, but some of the other changes we are thinking of
might not be specific to just embedded.

I will do some runtime testing on your patch, but I probably won't be
able to report back until Monday.

Thanks very much!
   -- Tim

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
