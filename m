Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKKWnN>; Mon, 11 Nov 2002 17:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSKKWnM>; Mon, 11 Nov 2002 17:43:12 -0500
Received: from host194.steeleye.com ([66.206.164.34]:19984 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261356AbSKKWnM>; Mon, 11 Nov 2002 17:43:12 -0500
Message-Id: <200211112249.gABMnux21337@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: john stultz <johnstul@us.ibm.com>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46 
In-Reply-To: Message from john stultz <johnstul@us.ibm.com> 
   of "11 Nov 2002 13:58:44 PST." <1037051926.3844.4.camel@cornchips> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Nov 2002 17:49:56 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnstul@us.ibm.com said:
> We'd still need to go back and yank out the #ifdef CONFIG_X86_TSC'ed
> macros in profile.h and pksched.h or replace them w/ inlines that wrap
> the rdtsc calls w/ if(cpu_has_tsc && !tsc_disable) or some such line.

Actually, the best way to do this might be to vector the rdtsc calls through a 
function pointer (i.e. they return zero always if the TSC is disabled, or the 
TSC value if it's OK).  I think this might be better than checking the 
cpu_has_tsc flag in the code (well it's more expandable anyway, it won't be 
faster...)

When the TSC code is sorted out on a per cpu basis, consumers are probably 
going to expect rdtsc to return usable values whatever CPU it is called on, so 
vectoring the calls now may help this.

James


