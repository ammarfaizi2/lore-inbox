Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbRFTJeT>; Wed, 20 Jun 2001 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264869AbRFTJeI>; Wed, 20 Jun 2001 05:34:08 -0400
Received: from gleb.nbase.co.il ([194.90.136.56]:9478 "EHLO gleb.nbase.co.il")
	by vger.kernel.org with ESMTP id <S264868AbRFTJdv>;
	Wed, 20 Jun 2001 05:33:51 -0400
From: Gleb Natapov <gleb@nbase.co.il>
Date: Wed, 20 Jun 2001 12:32:33 +0300
To: "David S. Miller" <davem@redhat.com>
Cc: Dax Kelson <dkelson@gurulabs.com>, Ben Greear <greearb@candelatech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>
Subject: Re: Should VLANs be devices or something else?
Message-ID: <20010620123233.F18523@nbase.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15151.55017.371775.585016@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 03:49:13PM -0700, David S. Miller wrote:
> 
> Dax Kelson writes:
>  > On Tue, 19 Jun 2001, Ben Greear wrote:
>  > > Should VLANs be devices or some other thing?
>  > 
>  > I would vote that VLANs be devices.
>  > 
>  > Conceptually, VLANs as network devices is a no brainer.
> 
> Conceptually, svr4 streams are a beautiful and elegant
> mechanism. :-)
> 
> Technical implementation level concerns need to be considered
> as well as "does it look nice".

How can I implement intermediate layer between L3 and L2 in the current 
kernel? This is what VLAN is all about. The only way to do it today is to 
pretend to be a network device for L3, do your job (adding VLAN header) and 
the job of L2 (build ethernet header) and queue packet to master device for 
transition. This is what ipip module does, this is what bonding module does 
and many others. And this is because L1 and L2 coupled too tightly together in 
the kernel now. In fact it is almost impossible to implement new L2 protocol without 
changing net_device structure. Something should be done about L1+L2 design till then 
pretend to be the net_device is the only solution if you want VLAN to be transparent 
for L3 protocols. If you want to implement VLANs only for IP layer this can be done
differently of course.

P.S: This topic was already discussed on netdev list before (and not once I think :)). 

--
			Gleb.
