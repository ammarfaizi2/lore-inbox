Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261214AbRERRO2>; Fri, 18 May 2001 13:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261219AbRERROJ>; Fri, 18 May 2001 13:14:09 -0400
Received: from [207.213.212.4] ([207.213.212.4]:21727 "EHLO geos.coastside.net")
	by vger.kernel.org with ESMTP id <S261214AbRERRN4>;
	Fri, 18 May 2001 13:13:56 -0400
Mime-Version: 1.0
Message-Id: <p05100301b72aee1f0b6c@[207.213.214.37]>
In-Reply-To: <C1256A50.0026C177.00@d12mta05.de.ibm.com>
In-Reply-To: <C1256A50.0026C177.00@d12mta05.de.ibm.com>
Date: Fri, 18 May 2001 08:32:36 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Storage - redundant path failover / failback - quo vadis 	
 linux?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:03 AM +0200 2001-05-18, Stefan.Bader@de.ibm.com wrote:
>  >My question is which way is the more probable solution for future linux
>  >kernels?
>  >The low-level-approach of the "T3"-patch requires changes to the
>  >scsi-drivers and the hardware-drivers but provides optimal communication
>  >between the driver and the hardware
>
>Thinking about it: if there would be some sort of 'available' flag 
>in the gendisk structure, that would be updated by the low-level 
>drivers. This could the used by a high-level design to use or skip a 
>failed device/path... In the S/390 (or zSeries) environment the 
>device drivers are even able to detect a failing connection even if 
>there is no data going to a device. That way the device would be 
>disabled even _before_ anybody tries to write...
>
>  >The high-level-approach of the "multipath"-personality is
>  >hardware-independant but works very slowly. On the other hand I see no
>  >clear way how to check for availability of the (previously failed) primary
>  >channel to automate a fail-back.
>
>Well, slower, but I think there will be many that take that 
>performance loss already by using lvm or md (for the benefit of 
>flexible/large filesystems) this approach would add failover while 
>beeing IMHO only a little less performant.

The flag idea, or some equivalent way for the low-level driver to 
communicate to the multi-pathing level, seems exactly right. I'm 
guessing that provision needs to be made for some 
external-device-dependent means of signalling both failure and 
recovery. There are potentially side-channel/out-of-band means to 
communicate this kind of status from specific devices.
-- 
/Jonathan Lundell.
