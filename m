Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVHYAvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVHYAvD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVHYAvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:51:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:27558 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932455AbVHYAvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:51:02 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:49:03 +1000
Message-Id: <1124930943.5159.168.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think what I'd like to see is that when a slot gets isolated and the
> driver doesn't have recovery code, the kernel calls the driver's
> unplug function and generates a hotplug event to udev.  Ideally this
> would be a variant of the remove event which would say "and by the
> way, please try replugging this slot when you've finished handling the
> remove event" or something along those lines.

I'm still trying to understand why we care. What prevents us from just
uplugging the previous device and re-plugging right away ? After all,
the driver->remove() function is supposed to guarantee that no HW access
will happen after it returns and that everything was unmapped.

Of course, we'll possibly end up with a different ethX or whatever, but
I don't see the problem with that ... It's hopeless to think we might
manage to keep that identical anyway, unless the driver implements
proper error recovery.

Ben.


