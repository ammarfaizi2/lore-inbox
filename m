Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293051AbSBWABV>; Fri, 22 Feb 2002 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293046AbSBWABO>; Fri, 22 Feb 2002 19:01:14 -0500
Received: from bgp387566bgs.jersyc01.nj.comcast.net ([68.36.43.111]:64521 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S293048AbSBWAA4>;
	Fri, 22 Feb 2002 19:00:56 -0500
Date: Fri, 22 Feb 2002 19:00:53 -0500
Message-Id: <200202230000.g1N00rw21538@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: harish.vasudeva@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need some help with IP/TCP Checksum Offload
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E6@caexmta9.amd.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.17 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
