Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUDCDpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 22:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUDCDpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 22:45:45 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:1468 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S261440AbUDCDpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 22:45:40 -0500
Subject: Re: pc card hangs computer with 2.6 kernel (more details)
From: Aubin LaBrosse <arl8778@rit.edu>
To: Samuel Sieb <samuel@sieb.net>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <406E2392.2090804@sieb.net>
References: <406E2392.2090804@sieb.net>
Content-Type: multipart/mixed; boundary="=-dGCiW45TIzVzbYBZlcnV"
Message-Id: <1080963939.7055.159.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Apr 2004 22:45:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dGCiW45TIzVzbYBZlcnV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 2004-04-02 at 21:38, Samuel Sieb wrote:
> I sent this originally to the pcmcia list, but haven't seen a response yet.
> 
> My laptop freezes as soon as I insert a Linksys WPC11 card which is an
> 802.11b wireless card.  I don't think it's the driver since as far as I
> can tell, the drivers aren't included in the kernel (it's a prism 2).  I
> first tried with a 2.6.1 kernel and then upgraded to 2.6.4 but it still
> acts the same.  (I'm using Fedora Core Testing, updated to latest.)
> 
> The laptop is a Compaq Presario 2190

I had similar issues with an hp laptop which was running fedora at the
time. It turns out to be the fedora pcmcia config vs the laptop.  You
can try this /etc/pcmcia/config.opts file, originally posted by Mathieu
Lesniak (Thanks Mathieu!) in response to my issue - it forces pcmcia to
use a specific irq and memory range, and it Worked For Me (tm)

--aubin

--=-dGCiW45TIzVzbYBZlcnV
Content-Description: 
Content-Disposition: attachment; filename=config.opts
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#
# Local PCMCIA Configuration File
#
#----------------------------------------------------------------------

# System resources available for PCMCIA devices

#include port 0x100-0x4ff, port 0xc00-0xcff
include port 0xfd00-0xfdff, port 0xfc00-0xfcff
#include memory 0xc0000-0xfffff
#include memory 0xa0000000-0xa0ffffff, memory 0x60000000-0x60ffffff
include memory 0x80000000-0x80000fff, memory 0xffeff000-0xffefffff
include memory 0xfbeff000-0xffefefff, memory 0x000d7000-0x000d7fff

# High port numbers do not always work...
# include port 0x1000-0x17ff

# Extra port range for IBM Token Ring
#include port 0xa00-0xaff

# Resources we should not use, even if they appear to be available

# First built-in serial port
exclude irq 3
exclude irq 4
#exclude irq 7
exclude irq 10
exclude irq 12

exclude irq 1
exclude irq 2
exclude irq 3
exclude irq 4
exclude irq 5
exclude irq 6
exclude irq 8
exclude irq 9
exclude irq 10
exclude irq 11
exclude irq 12
exclude irq 13
exclude irq 14
exclude irq 15



# Second built-in serial port
#exclude irq 3
# First built-in parallel port
#exclude irq 7
# PS/2 Mouse controller port, comment this out if you don't have a PS/2
# based mouse
#exclude irq 12
#
#----------------------------------------------------------------------

# Examples of options for loadable modules

# To fix sluggish network with IBM ethernet adapter...
#module "pcnet_cs" opts "mem_speed=600"

# Options for IBM Token Ring adapters
#module "ibmtr_cs" opts "mmiobase=0xd0000 srambase=0xd4000"

# Options for Raylink/WebGear driver: uncomment only one line...
# Generic ad-hoc network
module "ray_cs" opts "essid=ADHOC_ESSID hop_dwell=128 beacon_period=256 translate=1"
# Infrastructure network for older cards
#module "ray_cs" opts "net_type=1 essid=ESSID1"
# Infrastructure network for WebGear
#module "ray_cs" opts "net_type=1 essid=ESSID1 translate=1 hop_dwell=128 beacon_period=256"

# Options for WaveLAN/IEEE driver (AccessPoint mode)...
#module "wvlan_cs" opts "station_name=MY_PC"
# Options for WaveLAN/IEEE driver (ad-hoc mode)...
#module "wvlan_cs" opts "port_type=3 channel=1 station_name=MY_PC"

# Options for Xircom Netwave driver...
#module "netwave_cs" opts "domain=0x100 scramble_key=0x0"



--=-dGCiW45TIzVzbYBZlcnV--

