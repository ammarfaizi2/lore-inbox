Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTL3EPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTL3EPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:15:23 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:7287 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264372AbTL3EPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:15:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Subject: Re: 2.6.0-mm2
Date: Mon, 29 Dec 2003 23:15:08 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031229013223.75c531ed.akpm@osdl.org> <200312291832.35367.dtor_core@ameritech.net> <Pine.LNX.4.58.0312300247570.25540@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0312300247570.25540@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312292315.08854.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 10:05 pm, Marcos D. Marado Torres wrote:
[..SKIP..]
> If I select SYNAPTICS then my mouse taps are over, so I don't use
> synaptics at all...
>
> In -mm sources (and as I can see in -bk1 it will be in the main branch
> too) the patch to remove synaptics configuration option was added, so I
> have no way (as far as I can see) to just say that I don't want to use
> Synaptics, so I can't solve this problem... .config goes:
>
[..SKIP..]
>
> Of course that being my mouse a Synaptics (at least according to ASUS),
> Synaptics should give me the mouse taps, but seeing it does not, I
> would like at least to have the option not to compile it...
>
> Further, the idea I got from this patch:
>
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-dtor_core
>@ameritech.net|ChangeSet|20031219053552|02923.txt
>
> was that the option made no sense since people with no (or bad)
> synaptics support wouldn't "suffer" from this (in my case I should
> still have those mouse taps...)
>
> Well, there's a chance that there's something I am doing wrong or
> somewhere my logic fails, so feedback on this is wanted...
>

OK, I understand your concerns. Synaptics support had its share of problems
and being incompatible with all other mice "scared" off a lot of people.
Since then translation from absolute to relative (compatible with other mice)
mode was added to mousedev. This translation allows userspace see touchpad
as a regular PS2 mice, bare protocol and no support for tapping or any
advanced features. This is what you seem to be using at the moment. It is 
there to ease transition from older kernels, the mouse should just work. 
There was a couple quirks with it but they should be resolved in the latest
bk.

I think the best solution for you would be to grab the native Synaptics
driver for XFree86 at http://w1.894.telia.com/~u89404340/touchpad/index.html
and install it. Together with kernel piece it will give you support for
all Synaptics bells and whistles, such as multi-finger taps, corner taps,
edge scrolling. If you concerned with GPM console support there is a set
of patches for GPM at http://www.geocities.com/dt_or/gpm/gpm.html

If for some reason you do not want use your touchpad in native mode you can
disable it by passing psmouse_proto={bare|imps|exps} to the kernel. Any one
of them will suffice. It will disable touchpad's absolute mode and will
switch it to PS/2 hardware emulation, much like in 2.4. Now, in latest -bk
there is a problem passing parameters to psmouse if its compiled directly
into the kernel (you have to specify psmouse.psmouse_proto=... instead of
just psmouse_proto=...) but I will be sending patch for it shortly.

Please tell me if you still have any concerns regarding Synaptics support
and I will try to answer them.

Regards,

Dmitry  
