Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWCXXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWCXXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWCXXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:43:29 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51596 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932269AbWCXXn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:43:28 -0500
Date: Fri, 24 Mar 2006 17:43:06 -0600
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/6] PCIERR : interfaces for synchronous I/O error detection on driver
Message-ID: <20060324234306.GC21895@austin.ibm.com>
References: <44210D1B.7010806@jp.fujitsu.com> <20060322210157.GH12335@kroah.com> <4423A40D.3080906@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4423A40D.3080906@jp.fujitsu.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 04:47:25PM +0900, Hidetoshi Seto wrote:
> 
> At 2.6.16-rc1, Linux kernel accepts and provides "PCI-bus error event
> callbacks" that enable RAS-aware drivers to notice errors asynchronously,
> and to join following kernel-initiated PCI-bus error recovery.
> This callbacks work well on PPC64 where it was designed to fit.
> 
> However, some difficulty still remains to cover all possible error
> situations even if we use callbacks. It will not help keeping data
> integrity, passing no broken data to drivers and user lands, preventing
> applications from going crazy or sudden death.

This is not true.  Although there are some subtle issues, (which
I invite you to describe), the goal of the current design is to 
insure data integrity, and make sure that neither the driver nor 
the userland gets corrupted data. There shouldn't be any "crazy
or sudden death" if the device drivers are any good.

Of course, this depends on the hardware implementation. If
your PCI bus sends corrupt data up to the driver ... all bets 
are off. The design is predicated on the assumption that the
hardware sends either good data or no data, ad that the latter
is associated with a bus state indicating an error has ocurred.

>  - It will be useful if arch chooses panic on bus errors not to pass
>    any broken data to un-reliable drivers.

I assume you meant "if arch chooses NOT to panic on bus errors ..."

I'll review the rest of the patch via sepaate email

--linas
