Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTELXnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTELXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 19:43:10 -0400
Received: from holomorphy.com ([66.224.33.161]:1205 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262953AbTELXnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 19:43:08 -0400
Date: Mon, 12 May 2003 16:55:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn' t work due to /dev/rtc issues
Message-ID: <20030512235518.GN8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Chris Friesen' <cfriesen@nortelnetworks.com>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780CCB00AD@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780CCB00AD@orsmsx116.jf.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>> I don't understand why you're obsessed with interrupts. Just run your
>>> load and spray the scheduler latency stats out /proc/

From: Chris Friesen [mailto:cfriesen@nortelnetworks.com]
>> I'm obsessed with interrupts because it gives me a higher sampling rate.
>> I could set up and itimer for a recurring 10ms timeout and see how much
>> extra I waited, but then I can only get 100 samples/sec. With
>> /dev/rtc (on intel) you can get 20x more samples in the same amount
>> of time.

On Fri, May 09, 2003 at 05:39:03PM -0700, Perez-Gonzalez, Inaky wrote:
> Okay, crazy idea here ...
> You are talking about a bladed system, right? So probably you
> have two network interfaces in there [it should work only with
> one too].
> What if you rip off the driver for the network interface and 
> create a new breed. Set an special link with a null Ethernet
> cable and have one machine sending really short Ethernet frames

This is ridiculous. Just make sure you're not sharing interrupts and
count cycles starting at the ISR instead of wakeup and tag events
properly if you truly believe that to be your metric. You, as the
kernel, are notified whenever the interrupts occur and can just look
at the time of day and cycle counts.


-- wli
