Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422908AbWHYVDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWHYVDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWHYVDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:03:07 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:15071 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1422908AbWHYVDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:03:05 -0400
Date: Fri, 25 Aug 2006 17:03:05 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060825210305.GL13639@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156540817.3007.270.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 10:20:17PM +0100, Alan Cox wrote:
> That should be staying in order unless the device memory is mislabelled
> and prefetchable etc.

Hmm, no according to lspci the memory is labeled non-prefetachble, and
the pci bridge agrees with that setting too.

> What happens if you swap the memcpy_toio with while() writeb() ?

I tried changing it to a for loop that calles memcpy_toio with one byte
at a time, and it works fine that way (although probably less
efficient).  I expect the writeb one at a time will work too.

> They do a lot of stuff but it should not affect the PCI side and I'd
> expect it to do other things than byte lane re-ordering.

Yeah no kidding.

> Is the buffer 32bit aligned ?

I honestly don't know.  I am just trying to figure out why the jsm
driver isn't working on this system while it works on other types of
hardware, and so far it seems to come down to the __memcpy assembly not
being happy on the SC1200 doing more than one byte at a time.  it is
very consistently making the same mistake all the time.

--
Len Sorensen
