Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274064AbRJFMS4>; Sat, 6 Oct 2001 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRJFMSq>; Sat, 6 Oct 2001 08:18:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16402 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274064AbRJFMSg>;
	Sat, 6 Oct 2001 08:18:36 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.63138.941581.771248@cargo.ozlabs.ibm.com>
Date: Sat, 6 Oct 2001 22:18:42 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: jes@sunsite.dk, James.Bottomley@HansenPartnership.com,
        linuxopinion@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <20011006.013819.17864926.davem@redhat.com>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
	<d3n136tc48.fsf@lxplus014.cern.ch>
	<15294.47999.501719.858693@cargo.ozlabs.ibm.com>
	<20011006.013819.17864926.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> I can not even count on one hand how many people I've helped
> converting, who wanted a bus_to_virt() and when I showed them
> how to do it with information the device provided already they
> said "oh wow, I never would have thought of that".  That process
> won't happen as often with the suggested feature.

Well, let's see if we can come up with a way to achieve this goal as
well as the other.

I look at all the hash-table stuff in the usb-ohci driver and I think
to myself about all the complexity that is there (and I haven't
managed to convince myself yet that it is actually SMP-safe) and all
the time wasted doing that stuff, when on probably 95% of the
machines that use the usb-ohci driver, the hashing stuff is totally
unnecessary.  I am talking about powermacs, which don't have an iommu,
and where the reverse mapping is as simple as adding a constant.

That was my second argument, which you didn't reply to - that doing
the reverse mapping is very simple on some platforms, and so the right
place to do reverse mapping is in the platform-aware code, not in the
drivers.  On other platforms the reverse mapping is more complex, but
the complexity is bounded by the complexity that is already there in
drivers like the usb-ohci driver.

> I am adamently against generic infrastructure to do this.  Yes, it's
> social engineering, tough cookies... it's social engineering that I
> know is working :-)

Well, I don't maintain any of the affected drivers, so it's not an
issue that affects me personally.

Maybe we want a reverse-mapping API with a copyright notice on it that
says you can't use it unless you have written permission from David
S. Miller.  Just joking, but I do think that we should see if we can
think of something that achieves that sort of effect while still
making the facilities available for the drivers that truly do need it.

Regards,
Paul.
