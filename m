Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279024AbRJZTpq>; Fri, 26 Oct 2001 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279081AbRJZTpg>; Fri, 26 Oct 2001 15:45:36 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54069 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279024AbRJZTpY>; Fri, 26 Oct 2001 15:45:24 -0400
Date: Fri, 26 Oct 2001 15:46:00 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Christian Widmer <cwidmer@iiic.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: priority queues on dp83820
Message-ID: <20011026154600.A25890@redhat.com>
In-Reply-To: <200110261415.f9QEF9305606@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110261415.f9QEF9305606@mail.swissonline.ch>; from cwidmer@iiic.ethz.ch on Fri, Oct 26, 2001 at 04:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 04:01:48PM +0200, Christian Widmer wrote:
> has anybody try to use the priority queues of the dp83820?
> or does somebody know where to get docu knewer then the 
> preliminary form february 2001?

I've not tried implementing priority queuing ins ns83820.c, but 
the docs from Febuary 2001 are reasonably complete.

> i wrote a driver for the dp83820. now i tried to use 
> priority queuing for prescheduled zero copy datastreans.
> first i just whanted enable priority queueing without 
> inserting of any vlan tag. this works for 1 to 3 queues 
> like it sais in the docu (untagged packets are queued 
> like packets with priority 0). but when i enable the 4th
> queue i receive all none tagged data on queue 1 instead 
> of queue 0. and if i enalbe vlan-tagging globaly or on 
> a per packet basis i don't get any interrupts on the 
> receiving side. has anybody an idea whats going on. if 
> you need the code to have a lock at - let me know, i 
> realy need some help.

The receiver won't accept packets if they do not match the filter 
and filtering is enabled.  If you have any of the reject bits set 
in the RXCFG register, that could well be tripping your code up.

		-ben
