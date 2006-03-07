Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWCGVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWCGVqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWCGVqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:46:14 -0500
Received: from hpcn.ca.sandia.gov ([146.246.248.58]:3556 "EHLO
	hpcn.ca.sandia.gov") by vger.kernel.org with ESMTP id S964776AbWCGVqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:46:13 -0500
Subject: Re: [openib-general] Re: TSO and IPoIB performance degradation
From: Matt Leininger <mlleinin@hpcn.ca.sandia.gov>
To: Shirley Ma <xma@us.ibm.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>,
       mst@mellanox.co.il
In-Reply-To: <OF336D72E6.999D2A30-ON8725712A.00117C92-8825712A.00116629@us.ibm.com>
References: <OF336D72E6.999D2A30-ON8725712A.00117C92-8825712A.00116629@us.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:44:51 -0800
Message-Id: <1141767891.6119.903.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 19:13 -0800, Shirley Ma wrote:
> 
> > More likely you are getting hit by the fact that TSO prevents the
> congestion
> window from increasing properly. This was fixed in 2.6.15 (around mid
> of Nov 2005). 
> 
> Yep, I noticed the same problem. After updating to the new kernel, the
> performance are much better, but it's still lower than before.

 Here is an updated version of OpenIB IPoIB performance for various
kernels with and without one of the TSO patches.  The netperf
performance for the latest kernels has not improved the TSO performance
drop.

  Any comments or suggestions would be appreciated.

  - Matt

> 
All benchmarks are with RHEL4 x86_64 with HCA FW v4.7.0
dual EM64T 3.2 GHz PCIe IB HCA (memfull)
patch 1 - remove changeset 314324121f9b94b2ca657a494cf2b9cb0e4a28cc

Kernel                OpenIB    msi_x  netperf (MB/s)  
2.6.16-rc5           in-kernel    1     367
2.6.15               in-kernel    1     382
2.6.14-rc4 patch 1   in-kernel    1     434 
2.6.14-rc4           in-kernel    1     385 
2.6.14-rc3           in-kernel    1     374 
2.6.13.2             svn3627      1     386 
2.6.13.2 patch 1     svn3627      1     446 
2.6.13.2             in-kernel    1     394 
2.6.13-rc3 patch 12  in-kernel    1     442 
2.6.13-rc3 patch 1   in-kernel    1     450 
2.6.13-rc3           in-kernel    1     395
2.6.12.5-lustre      in-kernel    1     399  
2.6.12.5 patch 1     in-kernel    1     464
2.6.12.5             in-kernel    1     402 
2.6.12               in-kernel    1     406 
2.6.12-rc6 patch 1   in-kernel    1     470 
2.6.12-rc6           in-kernel    1     407
2.6.12-rc5           in-kernel    1     405 
2.6.12-rc5 patch 1   in-kernel    1     474
2.6.12-rc4           in-kernel    1     470 
2.6.12-rc3           in-kernel    1     466 
2.6.12-rc2           in-kernel    1     469 
2.6.12-rc1           in-kernel    1     466
2.6.11               in-kernel    1     464 
2.6.11               svn3687      1     464 
2.6.9-11.ELsmp       svn3513      1     425  (Woody's results, 3.6Ghz
EM64T) 


