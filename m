Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSFTTQX>; Thu, 20 Jun 2002 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSFTTQW>; Thu, 20 Jun 2002 15:16:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28797 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314811AbSFTTQU>; Thu, 20 Jun 2002 15:16:20 -0400
Date: Thu, 20 Jun 2002 15:16:22 -0400
From: Doug Ledford <dledford@redhat.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Nick Papadonis <nick@coelacanth.com>, linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX + v2.4.18 problems?
Message-ID: <20020620151622.D9181@redhat.com>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Nick Papadonis <nick@coelacanth.com>, linux-kernel@vger.kernel.org
References: <m3k7ov2tly.fsf@noop.bombay> <20020619214925.GA1739@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020619214925.GA1739@werewolf.able.es>; from jamagallon@able.es on Wed, Jun 19, 2002 at 11:49:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:49:25PM +0200, J.A. Magallon wrote:
> You are hangin things on the 50pin connector, which is SE, so you could never
> get 160Mb/s (LVD, transmit on up and down), you could at most go at 80Mb/s.

80MB/s is also LVD.  The fastest you can go on a SE narrow chain is in 
fact 20MB/s.

> >
> >Channel A Target 0 Negotiation Settings
> >        User: 40.000MB/s transfers (40.000MHz DT, offset 255)
> >        Goal: 20.000MB/s transfers (20.000MHz, offset 31)
> >        Curr: 20.000MB/s transfers (20.000MHz, offset 31)
> 
> Hardware thinks the disk just can do Goal=20Mb/s. Why ?

The 29160 card detects which cable a device is hooked to and the driver 
then sets the maximum allowed speed according to that.  When you plug a 
drive into a SE cable, the driver knows it and sets the maximum speed to 
SE speeds.

> It says nothing about 16 bits... Are you forcing it to narrow
> with a jumper ??

16bit is off in the BIOS settings, so it wouldn't get used regardless.

> >Channel A Target 2 Negotiation Settings
> >        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
> >        Goal: 20.000MB/s transfers (20.000MHz, offset 15)
> >        Curr: 20.000MB/s transfers (20.000MHz, offset 15)
> 
> It recognizes the drive can do wide, but as the first device in the
> chain forced narrow, goal is narrow.

No, the order of devices has no impact on this.  No device has any impact 
on any other device's speed settings unless they are both connected to the 
same physical cable and one of the devices is forcing a cable that *could* 
be in LVD mode into SE mode instead.  Short of that, all device 
negotiations are 100% independant of each other.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
