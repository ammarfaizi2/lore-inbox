Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288494AbSADE7e>; Thu, 3 Jan 2002 23:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288491AbSADE7N>; Thu, 3 Jan 2002 23:59:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:6456 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288490AbSADE7L>; Thu, 3 Jan 2002 23:59:11 -0500
Message-ID: <3C35369D.5040600@redhat.com>
Date: Thu, 03 Jan 2002 23:59:09 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nick Papadonis <nick@coelacanth.com>
CC: Nathan Bryant <nbryant@allegientsystems.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com>	<3C345493.5040800@evision-ventures.com>	<20020103154718.C32419@infosys.tuwien.ac.at>	<3C347A12.3070404@evision-ventures.com>	<3C34B35A.7000309@allegientsystems.com> <m3ell76p4h.fsf@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Papadonis wrote:

> I tried the 0.13 driver yesterday.  It appears to work fine, but when
> I insert my Orinoco WaveLan card they system locks up.  I reverted to
> the i810 audio driver included in kernel v2.4.16 and this problem
> isn't encountered.
> 
> Is there a conflict with the orinoco and orinoco_cs drivers from
> kernel v2.4.16?


Possibly.  If anything it's likely that either the orinoco or the i810 
driver is not handling spurious interrupts properly.  Now, since I've been 
using my i810 device in a machine that doesn't share it's interrupt I can't 
*personally* vouch that it handles things properly, but from looking at the 
interrupt handler code, it should.  The other possibility is that the 
orinoco might enable interrupts on the pcmcia slot before it actually 
registers its own interrupt handler.  If it does, and the card already has 
the interrupt line lit up, then it can generate an interrupt storm that 
looks like a machine lockup.  A way to test that is to unload the i810 sound 
driver and anything else that might use the interrupt the orinoco uses, then 
load the orinoco, wait until it's fully up and running, then load the i810 
driver and see if things work that way.  If it does, then it's almost 
certainly an init sequence issue in the orinoco driver.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

