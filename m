Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbTAQFXK>; Fri, 17 Jan 2003 00:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbTAQFXK>; Fri, 17 Jan 2003 00:23:10 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:59324 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267381AbTAQFXJ>; Fri, 17 Jan 2003 00:23:09 -0500
Date: Fri, 17 Jan 2003 00:32:02 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Re: [BUG][2.5]deadlock on cpci hot insert
In-Reply-To: <1042749763.1535.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301161752320.22716-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2003, Rusty Lynch wrote:

> On Wed, 2003-01-15 at 23:04, Rusty Lynch wrote:
> > On Wed, 2003-01-15 at 21:33, Scott Murray wrote:
> > > PS: Any word on whether my ZT5550 driver patch from last Friday fixes
> > >     your ZT5084 chassis issues?
> > 
> > Oh yea, that's the other thing I was going to do.  I just built and
> > installed the patched kernel with no problems, but I will be able to say
> > more after I have physical access to my lab tomorrow.
> > 
> >     --rustyl
> 
> The cpcihp_zt5550 patch you sent last Friday does not work on my 
> ZT5084 chassis because it does not detect any active cpci busses,
> and therefore doesn't register any cpci busses, and eventually
> gives up when cpci_hp_start fails (since slots == 0).

Doh!

> >From my dmesg, I can see:
> cpcihp_zt5550: HCF_HCS = 0x0000003b
> 
> I added a couple of debug messages before calling cpci_hp_start.
> dbg("Bus #1 is %s", hcf_hcs & HCS_BUS1_ACTIVE ? "active":"not active");
> dbg("Bus #2 is %s", hcf_hcs & HCS_BUS2_ACTIVE ? "active":"not active");
>
> which end up in dmesg as:
> cpcihp_zt5550: Bus #1 is not active
> cpcihp_zt5550: Bus #2 is not active
[snip]

Hmm, that's definitely not what I expected.  For reference, my test ZT5550 
here yields HCF_HCS = 0x31a in a standard (non-RSS) cPCI chassis, which
means both buses are active in my setup, and I'd expected the same from an
Active-Active or Locked Active-Active setup in a ZT5084 chassis.  I'll dig 
deeper in the host controller docs tomorrow as well as try and glean 
something from the rough 2.2 RSS code Intel/Ziatech released in late 2001.  
In the meantime, could you describe for me what you've got the "High 
Availability" options in your ZT5550's BIOS set to?  Also, just so I'm 
clear on what your setup consists of, am I correct in my assumption that 
you only have a single ZT5550 in your ZT5084 chassis?

Thanks,

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


