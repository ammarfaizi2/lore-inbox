Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272233AbRHWJH6>; Thu, 23 Aug 2001 05:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272237AbRHWJHs>; Thu, 23 Aug 2001 05:07:48 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:53400 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S272233AbRHWJHg>; Thu, 23 Aug 2001 05:07:36 -0400
Importance: Normal
Subject: Re: Allocation of sk_buffs in the kernel
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFB9404E0F.66393790-ONC1256AB1.00319EC3@de.ibm.com>
From: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Date: Thu, 23 Aug 2001 11:07:44 +0200
X-MIMETrack: Serialize by Router on d12ml040/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 23/08/2001 11:07:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm currently writing a kernel patch where it is essential to get
known>
> > when a sk_buff is allocated. Or better said I have to get known when a
> > sk_buff is effectively a new packet in the kernel-
>I don't want to guess why you need that...
I'm currently writing a stack profiler as my diploma thesis. It should give
a statistic how long a packet takes from one part of the network stack to
the other. So I have to watch the sk_buffs travelling through the kernel
and I need badly to know when they are allocated :) And, on top, the
deadline is in one week, and there are really strange things going on ;)

> > I currently identified 3 functions in the kernel where sk_buffs are
> > allocated: alloc_skb (of course), skb_linearize and pskb_expand_head.
Or at
> > least there new data is defined for the sk_buffs.
> >
> > Now I monitor a TCP session, a FTP download better said, and on the
> > interface arrives around 30000 packets for 50 MB of data. But in my
kernel
> > patch only 2000 packets are allocated, or at least I see only the
> > allocation of 2000 packets.
> >
> > Can anyone help me where I can find my missing packets? ;)) I need them
> > badly! *GG*

> There should be no skbuff allocation outside net/core/skbuff.c and all
> normal[1] networking drivers also don't use private pools. Perhaps
> you forgot to instrument a case there.
I have done some bit more testing yesterday, and the problem occurs in
either sending and receiving way, on two different ethernet drivers
(eepro100 and

