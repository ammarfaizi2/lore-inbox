Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279792AbRJ0JS5>; Sat, 27 Oct 2001 05:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279795AbRJ0JSs>; Sat, 27 Oct 2001 05:18:48 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:12041 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S279792AbRJ0JSd>; Sat, 27 Oct 2001 05:18:33 -0400
Message-Id: <200110270919.f9R9J2308329@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: priority queues on dp83820
Date: Sat, 27 Oct 2001 11:19:05 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200110261415.f9QEF9305606@mail.swissonline.ch> <200110262027.f9QKRm328534@mail.swissonline.ch>
In-Reply-To: <200110262027.f9QKRm328534@mail.swissonline.ch>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok it's me again. i got how priority queuing works. and
this is quite strange for the moment. when using 2 or 3
queues everything works like said in the docu. with 4
queues it gets wired. blow there's a list where the 
different user priorities in the VTID go:

2 queues:
---------
queue 0:	priorities: 0, 1, 2, 3, untagged framges
queue 1:	priorities: 4, 5, 6, 7

3 queues:
---------
queue 0:	priorities: 0, 1, 2, 3, untagged framges
queue 1:	priorities: 4, 5
queue 2:	priorities: 6, 7

4 queues:
---------
queue 0:	priorities: 1, 2
queue 1:	priorities: 0, 3, untagged framges
queue 2:	priorities: 4, 5
queue 3:	priorities: 6, 7


the step from 3 to 4 queues is quite amuseing. 

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
