Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSFNKyU>; Fri, 14 Jun 2002 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317205AbSFNKyT>; Fri, 14 Jun 2002 06:54:19 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:3588 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316655AbSFNKyS>; Fri, 14 Jun 2002 06:54:18 -0400
Message-ID: <3D09CB4F.B1913B95@aitel.hist.no>
Date: Fri, 14 Jun 2002 12:54:07 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6
In-Reply-To: <003601c212de$77316240$020da8c0@nitemare>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robbert Kouprie wrote:

> That could indeed be a problem. But this will become clear pretty soon
> once this APIC reprogramming workaround is actually implemented in the
> kernel. Then I will be able to test that. Any ideas how this workaround
> in the kernel would look like?

Not much.  Take a look at what happens in the kernel
when a pci device driver allocate an irq, and what happens 
when it releases it.

What you have to do, is probably to release the (broken) irq
without disturbing the driver's internal data.  Then
claim it again immediately on behalf of the driver.  You
have now treated the APIC the same way as a close/open do.
No interrupt from that device should happen in the middle
of this - but you should be fine as the irq supposedly is dead.

And this is something you'll have to do wherever the error
is detected, i.e. near the code that prints that message.

Helge Hafting
