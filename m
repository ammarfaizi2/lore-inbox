Return-Path: <linux-kernel-owner+w=401wt.eu-S933028AbWLLVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbWLLVft (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933042AbWLLVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:35:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:59035 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWLLVfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:35:47 -0500
Date: Tue, 12 Dec 2006 15:35:42 -0600
To: Greg KH <gregkh@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2]: Renumber PCI error enums to start at zero
Message-ID: <20061212213542.GK4329@austin.ibm.com>
References: <20061212195524.GG4329@austin.ibm.com> <20061212203543.GA4991@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212203543.GA4991@suse.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 12:35:43PM -0800, Greg KH wrote:
> On Tue, Dec 12, 2006 at 01:55:24PM -0600, Linas Vepstas wrote:
> > 
> > Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero
> > 
> > Renumber the PCI error enums to start at zero for "normal/online".
> > This allows un-initialized pci channel state (which defaults to zero)
> > to be interpreted as "normal".  Add very simple routine to check
> > state, just in case this ever has to be fiddled with again.
> 
> No, as you have a specific type for this state, never test it against
> "zero".  That just defeats the whole issue of having a special type for
> this state.

Yes, well, I guess that was my initial thinking, which is why it got
coded that way. But "in real life", the value in the struct isn't
initialized (thus taking a value of zero). Its not initialized 
in deference to the traditional idea that "just saying bzero() 
should be enough".  

However, that turned the test for error into a dorky double test:
if(pdev->error_state && pdev->error_state != pci_channel_io_normal)
which struck me as lame. 

So, I'll ask: is it better to test for (state!=0 && state!=1) or,
to initialize pdev->error_state = pci_channel_io_normal; in the driver 
probe code?

--linas
