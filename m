Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278555AbRJSRNO>; Fri, 19 Oct 2001 13:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278557AbRJSRNF>; Fri, 19 Oct 2001 13:13:05 -0400
Received: from geos.coastside.net ([207.213.212.4]:16048 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S278556AbRJSRM4>; Fri, 19 Oct 2001 13:12:56 -0400
Mime-Version: 1.0
Message-Id: <p05100301b7f60a7acc8e@[207.213.214.37]>
In-Reply-To: <3BCF3941.D4B79FE1@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.21.0110181034050.16868-100000@marty.infinity.powertie.org>
 <p05100309b7f4cd5976f7@[10.128.7.49]> <3BCF3941.D4B79FE1@mandrakesoft.com>
Date: Fri, 19 Oct 2001 10:12:53 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Cc: Patrick Mochel <mochelp@infinity.powertie.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:19 PM -0400 10/18/01, Jeff Garzik wrote:
>  > In this particular case, of course, the driver can keep a soft copy
>>  of the current MAC address and and restore from that, but that means
>>  making special cases of special things.
>
>For that specific case, NIC drivers should read a copy of the MAC
>address at probe time, and store it in dev->dev_addr.  Each power-up+if
>open cycle, the MAC address to programmed onto the NIC.  So that is not
>a special case but the normal case, keeping a soft copy of the MAC.
>
>Just being picky :)

No, you're right, and it's especially true of NIC drivers. Partly, I 
assume, because it's SOP in NIC drivers to routinely reinitialize the 
hardware after various errors. And for Ethernet makes it easy, 
because we're allowed to silently discard packets.

My own inclination would be to always keep enough information in 
driver structures to reinitialize the device, though I'd hesitate to 
assert that this is always possible, or practical.

WRT the suspend/resume sequence, I'd like to see the process 
extensible. So, for example, a single suspend entry point with an 
argument specifying the current action. The stuff I'm working on 
requires a kind of "suspend with extreme prejudice" in which the 
driver can't decline to suspend, as well as a suspend that comes 
*after* a bus (therefore device) reset (which would explain my urge 
to keep device state in soft structures). This is generally simple 
enough for Ethernet drivers, but a little trickier for other devices.

BTW (and excuse me for not searching this out, if it's available), is 
2.5 intended to have a real device tree? There's a related issue for 
suspend/resume, namely the hierarchical relationship of some devices 
(eg md->sd->adapter or whatever).
-- 
/Jonathan Lundell.
