Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTLPXkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTLPXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:40:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264375AbTLPXka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:40:30 -0500
Date: Tue, 16 Dec 2003 23:40:24 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Cc: Bryan Whitehead <driver@jpl.nasa.gov>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
Message-ID: <20031216234024.GP4176@parcelfarce.linux.theplanet.co.uk>
References: <3FDD7DFD.7020306@labs.fujitsu.com> <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov> <3FDF95EB.2080903@labs.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF95EB.2080903@labs.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 08:31:55AM +0900, Tsuchiya Yoshihiro wrote:
> Hi,
> 
> Stephen, I don't have anything helpful for debuging at this point. We 
> noticed the problem
> by debuging our SCSI driver. Then we found that the same thing happens 
> on generic
> SCSI disk and IDE also.  The problem we observed in our driver was that 
> while it is
> processing a buffer, which should be locked by BH_LOCK,  the contents of 
> the buffer were
> overwritten. The amount of overwrite is a few byte to 1KB out of 4KB, 
> which cannot be done
> in our driver. Then, we tried a generic SCSI and I reproduced the problem.
> I think it is not because of a broken pointer because overwrites only 
> happen in data buffers
> and other parts of memory seem ok.
 
Umm...  You do realize that if you have a shared writable mapping, the
buffer contents _can_ change during the IO?  Legitimately.  When dirty
page is being written to disk, it remains mapped.  So process can change
its contents just fine.

BH_LOCK does not prevent that and it was never supposed to...
