Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293422AbSBYQXL>; Mon, 25 Feb 2002 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293424AbSBYQXC>; Mon, 25 Feb 2002 11:23:02 -0500
Received: from age.cs.columbia.edu ([128.59.22.100]:23056 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S293422AbSBYQWo>; Mon, 25 Feb 2002 11:22:44 -0500
Date: Mon, 25 Feb 2002 11:22:37 -0500 (EST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: harish.vasudeva@amd.com
cc: linux-kernel@vger.kernel.org
Subject: RE: Need some help with IP/TCP Checksum Offload
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F280E9@caexmta9.amd.com>
Message-ID: <Pine.LNX.4.44.0202251120370.25679-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 harish.vasudeva@amd.com wrote:

> i tried setting the NETIF_F_SG flag, but the stack still gives the right checksum. 

Correct, not all packets will use the zerocopy framework. Using sendfile
is one way of generating them; I believe NFS will also do zerocopy but
I haven't checked it.

> Now, i have this 1 more question. If @ all the stack does offload chksum
> to the hardware, how will the driver come to know about this? Is there a
> per packet indication from the stack asking the driver
> TO-DO/OR-NOT-TO-DO chksum offloading?

Yes: skb->ip_summed == CHECKSUM_HW says the hardware is expected to 
generate the checksum.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

