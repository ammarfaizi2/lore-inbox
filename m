Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRJ1HbG>; Sun, 28 Oct 2001 02:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277746AbRJ1Ha5>; Sun, 28 Oct 2001 02:30:57 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:17225 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S277738AbRJ1Hat>; Sun, 28 Oct 2001 02:30:49 -0500
Message-Id: <200110280731.f9S7VO326133@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: <linux-kernel@vger.kernel.org>
Subject: Re: priority queues on dp83820
Date: Sun, 28 Oct 2001 08:31:27 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200110261415.f9QEF9305606@mail.swissonline.ch> <200110262027.f9QKRm328534@mail.swissonline.ch>
In-Reply-To: <200110262027.f9QKRm328534@mail.swissonline.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry i was wrong with the CRC. the problem seems to be 
that when inserting a vlan-tag the number of possible
padding data is 4 octes smaller. when stripping the 
vlantag off the dp83820 does not remember that it took
4 addtional bytes awai and marks the packet as a runt
packat.

chris

On Friday 26 October 2001 22:27, Christian Widmer wrote:
> ok for everybody how's also's working with the dp83820 i've
> somp partial results.
>
> i disabled priority queuing for the moment and started
> debuging the vlan-tag stuff.
>
> at the moment it seams that:
> it looks like that the 83820 inserts the vlan tag corretly
> and callculates CRC. on the receiving side it detects the
> vlan-tag. but don't run with the idea that you may ask for
> automaticaly strip of the vlantag again. if you try the
> 83820 gets confused with its own calculated CRC. when
> calculating CRC it must include the vlan tag on one side
> exclude it on the other side.
>
> how this works with priority queueing ?
>
> //chris
>
> On Friday 26 October 2001 16:01, Christian Widmer wrote:
> > has anybody try to use the priority queues of the dp83820?
> > or does somebody know where to get docu knewer then the
> > preliminary form february 2001?
> >
> > i wrote a driver for the dp83820. now i tried to use
> > priority queuing for prescheduled zero copy datastreans.
> > first i just whanted enable priority queueing without
> > inserting of any vlan tag. this works for 1 to 3 queues
> > like it sais in the docu (untagged packets are queued
> > like packets with priority 0). but when i enable the 4th
> > queue i receive all none tagged data on queue 1 instead
> > of queue 0. and if i enalbe vlan-tagging globaly or on
> > a per packet basis i don't get any interrupts on the
> > receiving side. has anybody an idea whats going on. if
> > you need the code to have a lock at - let me know, i
> > realy need some help.
> >
> > chris
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
