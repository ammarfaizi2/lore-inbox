Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSGUPtm>; Sun, 21 Jul 2002 11:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317697AbSGUPtm>; Sun, 21 Jul 2002 11:49:42 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:40964 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP
	id <S317696AbSGUPtm>; Sun, 21 Jul 2002 11:49:42 -0400
Date: Sun, 21 Jul 2002 16:52:46 +0100
From: Alasdair Kergon <agk@uk.sistina.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020721165246.A6194@uk.sistina.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.ke <p731y9xva8m.fsf@oldwotan.suse.de> <1027258811.17234.90.camel@irongate.swansea.linux.org.uk> <20020721161050.A10867@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020721161050.A10867@wotan.suse.de>; from ak@suse.de on Sun, Jul 21, 2002 at 04:10:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 04:10:50PM +0200, Andi Kleen wrote:
> The problem in my opinion with LVM2 is that the design makes it
> near impossible to get a stable ABI between user and kernel space
> (at least if you don't want to freeze it completely). 

> As far as I can see this problem is not addressed in LVM2 and its design
> makes it even harder to address than it was in LVM1

On the contrary, device-mapper (which is the name we have given to the
generic kernel driver that LVM2 uses) goes out of its way to learn
these lessons from LVM1 and to provide mechanisms so we can avoid this
sort of potential problem as new features are added etc.

Of course we hope the existing interface is reasonably stable and
changes will just be additions to support new features.  But
nevertheless LVM2/device-mapper is designed to cope with all sorts of
scenarios, including a single version of userspace tools working
sensibly with both older *and newer* versions of the kernel driver.

We have three layers:
  +------------+---------+------------+
  | LVM2 Tools | dmsetup | Other apps |  Userspace apps
  +------------+---------+------------+
  | device-mapper library             |  Userspace library
  +-----------------------------------+
  | device-mapper                     |  Kernel driver
  +-----------------------------------+

Userspace library/kernel driver interface:
  LVM1 attached a single version number to this ioctl interface,
  and a version number mismatch meant the tools would fail.

  The device-mapper ioctl interface attaches a 3-component version
  number to each individual command so we can handle fine-grained 
  forwards and/or backwards compatibility easily if we need to - and 
  in either the kernel or in the library as appropriate.

Alasdair
-- 
agk@uk.sistina.com
