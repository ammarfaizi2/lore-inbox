Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbTCTRrz>; Thu, 20 Mar 2003 12:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbTCTRrz>; Thu, 20 Mar 2003 12:47:55 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3746 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261620AbTCTRrx>; Thu, 20 Mar 2003 12:47:53 -0500
Message-ID: <3E7A0155.2020909@nortelnetworks.com>
Date: Thu, 20 Mar 2003 12:58:45 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: advice/gotchas about memory mapping across PCI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was hoping to get some advice about techniques or gotchas with respect to 
somthing that we're looking at.

We're planning on having two processors, each with local memory, both connected 
to the same pci bus.  One processor will run the main application (which is 
cpu-bound), and the other will offload all of the I/O and maintenance processes. 
  We need to implement some kind of messaging over the pci bus to allow the 
processors to communicate with each other, and this will be the only way for 
information to get to the application processor (except for a serial console for 
debugging).

There will ultimately be a number of communications channels but fundamentally 
they will all be similar so for now we can consider the case of just a single 
channel.

I was planning on implementing the communications based on a ringbuffer stored 
in the memory of the application processor (to minimize application delays due 
to pci accesses).  The other processor will access this buffer over the pci bus.

I assume that on the application processor I will need to place the ringbuffer 
at some known location so that the other processor can find it.  I would guess 
this means allocating it very early on so that I can be assured of getting the 
memory area that I want.

On the other processor, I think things should be more flexible since I should be 
able to map an arbitrary chunk of memory space over the pci bus to correspond to 
the fixed location of the buffer on the application processor.  Does this make 
sense?

When writing over the pci buffer, I'm sure that there will be concurrency 
issues.  Does anyone have any suggestions on how to manage these?  Is there such 
a thing as atomic operations over the pci bus?  I'm afraid that my knowledge at 
this level is somewhat hazy.  Would the ringbuffers in the ethernet drivers 
(which I've looked at a little bit) make a decent starting point?

Does anyone have any suggestions on what to read or where to look to get started?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

