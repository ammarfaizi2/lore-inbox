Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDAVFG>; Sun, 1 Apr 2001 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDAVE5>; Sun, 1 Apr 2001 17:04:57 -0400
Received: from gear.torque.net ([204.138.244.1]:5139 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132557AbRDAVEw>;
	Sun, 1 Apr 2001 17:04:52 -0400
Message-ID: <3AC797BB.D2AA2FE4@torque.net>
Date: Sun, 01 Apr 2001 17:03:55 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Daum <gator@cs.tu-berlin.de>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
   "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: scsi bus numbering
In-Reply-To: <Pine.LNX.4.30.0104012054180.779-100000@swamp.bayern.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Daum wrote:
> 
> On Sun, 1 Apr 2001, Douglas Gilbert wrote:
> 
> [...]
> 
> > >>>>>>>>>  scsihosts  <<<<<<<<<<<<<
> >
> > As a boot time option try:
> >   scsihosts=aic7xxx:ncr53c8xxx
> > or if you are using lilo, in /etc/lilo.conf add:
> >   append="scsihosts=aic7xxx:ncr53c8xxx"
> 
> that does indeed change the bus numbering. Unfortunately, even
> with this option, the first disk on the ncr controller becomes
> "/dev/sda" ...

Peter,
This indicates that the method being used by the 
new aic7xxx driver for initialization is broken 
with respect to other scsi adapters.

The intent is that all built in HBA drivers are
initialized _before_ the built in upper level 
drivers (e.g. sd). To get the effect you describe
the driver init order seems to have been:
  register ncr53c8xxx
  register sd
  register aic7xxx      # too late ...


Doug Gilbert
