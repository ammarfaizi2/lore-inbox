Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTFIQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTFIQC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:02:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264490AbTFIQCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:02:54 -0400
Date: Mon, 9 Jun 2003 09:18:03 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: mikpe@csd.uu.se
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <200306071034.h57AYKoq021460@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0306090911520.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >-EXPORT_SYMBOL(device_lapic);
> 
> Why did you ignore the 'not static' comment, and why remove
> the EXPORT? They're there for a reason...

Because it only appeared to be there to be able to set the parent device
for hierarchically dependent devices. Assuming that is not needed, then 
the EXPORT_SYMBOL() shouldn't be needed, and that device can be declared 
statically. Right? 

> Unless I'm missing something, you've just broken the hierarchical
> relationship that exists between the local APIC device and its
> client devices (NMI watchdog, oprofile [which you didn't convert],
> and perfctr [not merged into Linus' tree]).

I'm aware of the necessary ancstral relationship, and I should have 
mentioned this in the first email. Proper ancestral order is maintained by 
virtue of the fact that child devices are registered after parent devices. 
Because of this, they are inserted into the list of system devices after 
their parents, so by walking the list in reverse order, you are guaranteed 
to suspend/shutdown the devices in the right order. 

Note that I ommitted this from the patch and will add it in by the time I 
submit it to Linus. 


	-pat

