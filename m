Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293061AbSBWA5S>; Fri, 22 Feb 2002 19:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293062AbSBWA5I>; Fri, 22 Feb 2002 19:57:08 -0500
Received: from amdext.amd.com ([139.95.251.1]:64496 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S293061AbSBWA44>;
	Fri, 22 Feb 2002 19:56:56 -0500
From: harish.vasudeva@amd.com
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <CB35231B9D59D311B18600508B0EDF2F04F280E9@caexmta9.amd.com>
To: ionut@cs.columbia.edu
cc: linux-kernel@vger.kernel.org
Subject: RE: Need some help with IP/TCP Checksum Offload
Date: Fri, 22 Feb 2002 16:56:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1068375B4877452-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i tried setting the NETIF_F_SG flag, but the stack still gives the right checksum. 

Now, i have this 1 more question. If @ all the stack does offload chksum to the hardware, how will the driver come to know about this? Is there a per packet indication from the stack asking the driver TO-DO/OR-NOT-TO-DO chksum offloading?

thanx again
HV

-----Original Message-----
From: Ion Badulescu [mailto:ionut@cs.columbia.edu]
Sent: Friday, February 22, 2002 4:01 PM
To: Vasudeva, Harish
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need some help with IP/TCP Checksum Offload


On Fri, 22 Feb 2002 14:57:22 -0800, harish.vasudeva@amd.com wrote:
> 
> I am trying to offload checksum calculation to my hardware. What i am doing in my driver (kernel 2.4.6) is :
> 
> dev->features = NETIF_F_IP_CHECKSUM;
> 
> Then, in my start_xmit( ) routine, i am parsing for the right headers & when i get the IP/TCP header, i print out the checksum & it is already the right checksum. When does the OS/Protocol offload this task? Am i missing something here?

I haven't looked at this in a long time, but at the time the checksum
offloading support was introduced, the IP stack needed both NETIF_F_SG
and NETIF_F_IP_CSUM in dev->features before it would start offloading.

The idea was that cksum support without scatter-gather support is useless,
because the csum gets calculated essentially for free while copying the data
to linearize the skbuf.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

