Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSHPUwt>; Fri, 16 Aug 2002 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSHPUws>; Fri, 16 Aug 2002 16:52:48 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53474 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317102AbSHPUwr>; Fri, 16 Aug 2002 16:52:47 -0400
Message-ID: <3D5D6621.E33EA4BE@nortelnetworks.com>
Date: Fri, 16 Aug 2002 16:52:49 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Jon Burgess <Jon_Burgess@eur.3com.com>, henrique@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

> There is little to no reliably unpredictable data in network
> interrupts and the current scheme does not include for the mixing of
> untrusted sources. It's very likely that an attacker can measure,
> model, and control such timings down to the resolution of the PCI bus
> clock on a quiescent system. This is more than good enough to defeat
> entropy generation on systems without a TSC and given that the bus
> clock is a multiple of the processor clock, it's likely possible to
> extend this to TSC-based systems as well.

> Entropy accounting is very fickle - if you overestimate _at all_, your
> secret state becomes theoretically predictable. I have some patches
> that create an API for adding such hard to predict but potentially
> observable data to the entropy pool without accounting it as actual
> entropy, as well as cleaning up some other major accounting errors but
> I'm not quite done testing them.

The problem is this.  If you have an embedded system that is headless, diskless, keyboardless, and
mouseless, then your only remaining source of any interrupt-based entropy is the network.  Also, if
you add entropy to the pool without accounting it as entropy, then how does that help anything?  You
can currently add anything you want to the pool and it will stir it in but not bump the entropy
count.

Granted, a proper solution would involve a hardware-based system for entropy generation, but in the
absence of a proper solution you do the best you can.

For the general user, network-based interrupts are likely okay.  If you have an attacker
sophisticated enough that it can predict the arrival time of a network packet down to 30ns (the
timing of a 33MHz PCI bus) from across the network, then I think you will probably have the
resources for a hardware entropy generator.

This has been discussed many times, and the concensus seems to be that yes it is not secure, but
there are people who have literally no other option.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
