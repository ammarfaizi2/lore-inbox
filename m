Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935086AbWK1DpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935086AbWK1DpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 22:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935088AbWK1DpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 22:45:18 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:24381 "EHLO
	asav06.insightbb.com") by vger.kernel.org with ESMTP
	id S935086AbWK1DpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 22:45:17 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgoXAIo/a0VKhRUUVWdsb2JhbACBZoRDhjsBKw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [RFC/PATCH] Uncap max number of evdev devices [was: Re: need more events]
Date: Mon, 27 Nov 2006 22:45:19 -0500
User-Agent: KMail/1.9.3
Cc: juanslayton@dslextreme.com, linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <7c50a14e8ca157b0abe20a.20061124170952.whnafynlgba@www.dslextreme.com> <20061127185651.GC10879@austin.ibm.com>
In-Reply-To: <20061127185651.GC10879@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611272245.21645.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2006 13:56, Linas Vepstas wrote:
> On Fri, Nov 24, 2006 at 05:09:52PM -0800, juanslayton@dslextreme.com wrote:
> > 
> >      The object is to poll 20 usb keyboards in an elementary school
> > classroom, each of which generates 2
> > events (one keyboard and one mouse).  The stock kernel maxes out at event
> > 31, leaving me 4
> > keyboards short.
> >      I thought to fix this by changing the definition of EVDEV_MINORS
> > (line 12, evdev.c) from 32 to 64.  It almost worked.  The extra
> > events showed up in /dev/input/* and /proc/bus/input/devices.
> > However, attempting to access the new events in the application
> > program only yields a segmentation fault.  Obviously I've got to change
> > something else.
> 
> The problem is in input_register_handler() in drivers/input/input.c
> which does things like 
> if (input_table[handler->minor >> 5])
>  and 
> input_table[handler->minor >> 5] = handler;
> 
> which implicitly makes 32 the max. 
> 
> The kernel path below removes this limitation. Does it fix your problem?
> 

This makes /dev/input/js32-63 take over /dev/input/mouse0-31 which is
contrary to what Documentation/devices.txt says and therefore not a good
idea for the mainline.

I am planning to convert input core to cdevs and that table will go away
completely and then it can be discussed how to extend range of input
devices (probably by going beyond 256 minors?).

-- 
Dmitry
