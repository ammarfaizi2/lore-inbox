Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWGRKnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWGRKnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGRKnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:43:32 -0400
Received: from [216.208.38.107] ([216.208.38.107]:7553 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S1751271AbWGRKnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:43:31 -0400
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Ian Pratt <ian.pratt@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <278d0ba5a24d74c5b590dd76d234c312@cl.cam.ac.uk>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091958.414414000@sous-sol.org>
	 <1153218477.3038.46.camel@laptopd505.fenrus.org>
	 <278d0ba5a24d74c5b590dd76d234c312@cl.cam.ac.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:42:28 +0200
Message-Id: <1153219348.3038.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 11:35 +0100, Keir Fraser wrote:
> On 18 Jul 2006, at 11:27, Arjan van de Ven wrote:
> 
> > Hmmm maybe it's me, but something bugs me if a NIC driver is going to
> > send IP level ARP packets... that just feels very very wrong and is a
> > blatant layering violation.... shouldn't the ifup/ifconfig scripts just
> > be fixed instead if this is critical behavior?
> 
> Maybe we should be faking this out from our hotplug scripts in the 
> control VM, although triggering this from user space is probably a bit 
> of a pain. Regardless, the function can be removed from the driver if 
> it's too distasteful: it's only a performance 'hack' to get network 
> traffic more quickly redirected when migrating a VM between physical 
> hosts. Things won't break horribly if it's removed.


that sounds like a perfect job for a udev-kind of notification to
userspace, eg "hey I migrated", and then udev/hotplug can just do this
sending of arps.. maybe they also want to do other things just after a
migration (which sounds entirely reasonable to me) such as renewing the
dhcp lease, resetting the periodic userspace hardware polling timers in
"hal", network manager etc etc... 

so it looks entirely useful for me to have a userspace upcall for "post
migration", and once you have that that udev side of things can just do
this...

(question is if you also want a pre-migration upcall; my gut feeling
says "no" because upcalls are async and you may end up running that
upcall on the new physical machine)

Greetings,
   Arjan van de Ven

