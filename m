Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTJFPqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJFPqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:46:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262349AbTJFPqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:46:09 -0400
Date: Mon, 6 Oct 2003 16:46:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
Message-ID: <20031006154605.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <OFD63B1783.24148268-ONC1256DB7.005358E7-C1256DB7.0055CAB5@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD63B1783.24148268-ONC1256DB7.005358E7-C1256DB7.0055CAB5@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 05:37:04PM +0200, Martin Schwidefsky wrote:
> 
> > You can still have a reference to the object when the module is unloaded.
> >
> > unregistered != last reference is gone
> 
> Hmpf, I think I see the problem now. We'd need to wait in the module
> exit function until the release function for the root device has been
> called. Can't say I like it but it's probably the easiest way out.

That's a trivial deadlock.  You _can't_ do that sysfs.  Static kobject in
a module is a bug.  Period.
