Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266518AbUAOAD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUAOAD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:03:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65520 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266518AbUAOAC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:02:56 -0500
Message-ID: <4005D8A5.3010002@mvista.com>
Date: Wed, 14 Jan 2004 16:02:45 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matt Mackall <mpm@selenic.com>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net,
       discuss@x86-64.org, ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com> <20040114063155.GF28521@waste.org> <4005A03A.40409@mvista.com> <20040114232631.GB9983@kroah.com>
In-Reply-To: <20040114232631.GB9983@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jan 14, 2004 at 12:02:02PM -0800, George Anzinger wrote:
> 
>>Right.  I had hoped that we might one day be able to use the USB and I am 
>>sure there are others.
> 
> 
> Raw USB?  Or some kind of USB to serial device?
> 
> Remember, USB needs interrupts to work, see the kdb patches for the mess
> that people have tried to go through to send usb data without interrupts
> (doesn't really work...)

I gave up on USB when I asked the following questions:
1. How many different HW USB master devices need to be supported (i.e. appear on 
your normal line of MBs)? (answer, too many)
2. Can I isolate a USB port from the kernel so that it does not even know it is 
there? (answer: NO)

What I want is a USB port that is completely coded in kgdb software (keeps 
Heisenberg out).  It would be a polled device except for the ^C (or equivalent) 
interrupt.

We, of course, have the same issues with the eth interface.  Far too much of the 
rest of the kernel is involved in the communications with it.  Also there are 
way to many interfaces to code each one seperatly, thus the current effort using 
a good deal of the kernel to remove all that special code.  Of course Heisenberg 
and all his friends and relations are taking up residence in that code :)  Might 
not be too bad except that his uncle is Murphy.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

