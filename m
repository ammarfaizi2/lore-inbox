Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTJVPsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJVPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:48:47 -0400
Received: from CAT.NYU.EDU ([128.122.47.28]:40618 "EHLO cat.nyu.edu")
	by vger.kernel.org with ESMTP id S263466AbTJVPsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 11:48:43 -0400
Date: Wed, 22 Oct 2003 11:48:41 -0400 (EDT)
From: Daniel Thor Kristjansson <danielk@cat.nyu.edu>
Reply-To: danielk@mrl.nyu.edu
To: Dominik Brodowski <linux@brodo.de>
Cc: danielk@mrl.nyu.edu, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org, Mattia Dongili <dongili@supereva.it>
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state
 driver
In-Reply-To: <20031021203215.GE26971@brodo.de>
Message-ID: <Pine.SOL.4.53.0310221123140.9450@graphics.cat.nyu.edu>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
 <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home>
 <20031021101737.GA31352@wiggy.net> <20031021105234.GF893@inferi.kami.home>
 <Pine.SOL.4.53.0310211057060.6187@graphics.cat.nyu.edu> <20031021203215.GE26971@brodo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


]> The _user_ shouldn't set the cpu frequency hundred of times a second,
]> but a userland program should set the priorities. If you are just
]Wrong. Passing "events" or "information" to cpufreq governors by
]cpufreq_governor() is much easier, cheaper, and more reliable.

I think we may actually agree, but I may be wrong.

I have no problem with a governor setting the frequency and voltage
based on idle or temperature measurements only it can see efficiently.
But I think you still want more complex things to be decided in userland
which is more forgiving to programmer error. For instance this patch
does not allow you to tailor the polling frequency, if someone wrote a
such a governor that took battery into account my Vaio FXA53 would come
to a grinding halt as checking the battery through ACPI stops the
machine cold for about 200 ms. There is no need to poll the battery very
often, but someone with a fast battery check might do so simply out of
convenience.

]> CPUFreq has been rearchitectured to allow this type of thing,
]> you can have a governor in the kernel that sets CPU Frequency based on
]> load within limits specified by a userland program.
]Wrong again. CPUfreq has been rearchitectured to do this kernel-space.
]The userspace governor allows setting to specific frequencies by the user
]["I _want_ 500 MHz and nothing else!"], and it offers backwards
]compatibility for the first-era cpufreq interface [LART project etc.].
No, you can set a min and max frequency that the governor is allowed to
move within. This can be done by a userspace program through the /sys
interface. You can also use the "userspace" governor, but that's not
what I'm recommending.

]> ACPI can meantime throttle the CPU if it gets too hot
]However, frequency scaling is much more efficient on lowering the CPU heat,
]too.
Sure, a governor that does goes to the minimum frequency it's userland
governor has told it it has available to cool the CPU is a good thing.
Or, even below that if the CPU is near critical. If the CPU gets that
hot there is something wrong with the userland policy. Until this is
written, ACPI can act as a backup system to keep the CPU from burning
up.

]> The user may know things the kernel doesn't such as "this laptop is
]> burning a hole in my pants." She might want to construct a policy that
]Yes indeed. She wants to set a cpufreq policy which suits of her needs:
]it consists of a
]- minimum frequency	=> not too low [she's plugged in]
]- maximum frequency	=> 100%
]- cpufreq governor	=> some kind of yet-to-be-written
]				dynamic cpufreq governor with
]				temperature or long-term-statistic
]				knowledge.
Why not a sensible governor in the kernel and a userland governor that
sets the minimum and maximum for desired effect?

]_I_ wouldn't want to run this governor, though -- I want kernel compiles to
]complete as fast as possible. So, we need different in-kernel governors.
I think a governor could keep the CPU running at 100% for long enough to
finish a kernel compile while still slowing down for a really long
compile like KDE, Mozilla, etc. It might however be too complex for me
to feel comfortable with it in the kernel.

]Well, the thing one of the cpufreq userspace programs does is really fine:
]based on low-frequency events [power plug-in, running specific programs,
]etc.] different cpufreq policies [see above] are selected. No XML file
]necessary.

Yes, the userspace program can just switch from performance, to
something in between w/min/max, to powersave. My arguement is just
against making the "something in between" too complex, by for
instance taking the low-frequency events into account.

-- Daniel
  <<McCain was held in a bamboo cage and poked at with sticks for years.
    That's the kind of guy who should be in the White House.>> -- Anon.
