Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVCBDMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVCBDMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 22:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVCBDMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 22:12:46 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:21428 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262151AbVCBDMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:12:39 -0500
Message-ID: <42252F77.3050701@jp.fujitsu.com>
Date: Wed, 02 Mar 2005 12:13:59 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <200503010910.29460.jbarnes@engr.sgi.com>
In-Reply-To: <200503010910.29460.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> This was my thought too last time we had this discussion.  A completely 
> asynchronous call is probably needed in addition to Hidetoshi's proposed API, 
> since as you point out, the driver may not be running when an error occurs 
> (e.g. in the case of a DMA error or more general bus problem).  The async 
> ->error callback could do a total reset of the card, or something along those 
> lines as Jeff suggests, while the inline ioerr_clear/ioerr_check API could 
> potentially deal with errors as they happen (probably in the case of PIO 
> related errors), when the additional context may allow us to be smarter about 
> recovery.

Depend on the bridge implementation, special error handling of PCI-X would be
available in the case of a DMA error.

PCI-X Command register has Uncorrectable Data Error Recovery Enable bit to
avoid asserting SERR on error. Some bridge generates poisoned data and pass
it to destination instead of asserting error or passing broken data.

The device driver would be interrupted on the completion of DMA, and check
status register of controlling device to find a error during the DMA.
If there was a error, driver could attempt to recover from the error.

I don't know whether this is actually possible or not, and also there are
upcoming drivers implementing such special handling.

Though, when and how we should call drivers to do device specific staff is
one of the problem. My API would provide "a chance" which could be defined by
driver, at least.


Thanks,
H.Seto

