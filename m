Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292581AbSCDRb7>; Mon, 4 Mar 2002 12:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSCDRbo>; Mon, 4 Mar 2002 12:31:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25250 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292560AbSCDRbf>; Mon, 4 Mar 2002 12:31:35 -0500
Date: Mon, 4 Mar 2002 10:46:09 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
Message-ID: <20020304104609.C31523@vger.timpanogas.org>
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org> <E16hu0P-0007yq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16hu0P-0007yq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 04, 2002 at 03:04:00PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 03:04:00PM +0000, Alan Cox wrote:
> > provided for review.  Recommend a minumum change of increasing 
> > the sysctl_hot_list_len from 128 to 1024 by default.  I have reviewed 
> 
> Good way to kill low end boxes. It probably wants sizing based on system
> size and load monitoring. 
> 
> > NetWare always created ECB's (Event Control Blocks) at the max size
> > of the network adpapter rather than trying to allocate fragment 
> > elements on the fly the way is being done in Linux with skb's.  
> 
> Thats up to the network adapter. In fact the Linux drivers mostly do 
> keep preloaded with full sized buffers and only copy if the packet size
> is small (and copying 1 or 2 cache lines isnt going to hurt anyone)


There's an increase in latency.  For my application, I have no 
problem keeping around a local patch that corrects this behavior 
if folks don't feel it needs fixing.   From everything I've ever
done in this space, having needless alloc/free calls in a 
performance intensive path that requires low latency like a Lan 
driver is not a good thing.  

I am idle most of the time since I have eliminated all of the 
copy activity by using SCI in the system.  This is why it's 
idle most of the time.  Were I using the IP stack code in Linux
proper, the utilization would be through the roof.  

:-)

Jeff


> 
> >  28044 default_idle                             584.2500
> 
> You spent most of your time asleep 8)
> 
> >   1117 __rdtsc_delay                             34.9062
> 
> Or doing delays
> 
> >    927 eth_type_trans                             4.4567
> 
> And pulling a line into L1 cache
