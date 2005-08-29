Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVH2WcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVH2WcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbVH2WcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:32:22 -0400
Received: from kroah.com ([216.218.225.136]:7832 "HELO kroah.com")
	by vger.kernel.org with SMTP id S1751309AbVH2WcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:32:21 -0400
Date: Mon, 29 Aug 2005 15:32:11 -0700
From: Greg KH <greg@kroah.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Subject: Re: 2.6: how do I this in sysfs?
Message-ID: <20050829223211.GA17088@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
	Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mochel@osdl.org,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>,
	"Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>
References: <D4CFB69C345C394284E4B78B876C1CF10ABB0269@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10ABB0269@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.4.2i
X-Operating-System: Linux 2.4.25-ow1 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 12:24:18PM -0500, Miller, Mike (OS Dev) wrote:
> 
> > This is after my minimal sas transport class, please also 
> > read the thread about it on linux-scsi
> > 
> In the referenced code for using sysfs, there only appear to be methods
> for reading attributes.  How about if we want to cause a command to
> get written out to the hardware?   Do we do something like this?
> 
>         /* get a semaphore keep everyone else out while we're working,
>            and hope like hell that all the other processes are playing
>            nice and using the semaphore too, or else we're hosed. */
> 
>         get_some_kind_of_semaphore();

try flock() on the /sys/blah/blah/ directory.  That should keep userspace happy.  
I think it only takes a small sysfs patch to make this work (or it might work
today, don't remember, sorry...)

Or look into using configfs instead.

thanks,

greg k-h
