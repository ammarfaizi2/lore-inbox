Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292637AbSCDSKY>; Mon, 4 Mar 2002 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSCDSKP>; Mon, 4 Mar 2002 13:10:15 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:60546 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292612AbSCDSKG>; Mon, 4 Mar 2002 13:10:06 -0500
Date: Mon, 4 Mar 2002 18:09:38 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304180938.G1444@redhat.com>
In-Reply-To: <sct@redhat.com> <200203041735.g24HZOu09098@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203041735.g24HZOu09098@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Mar 04, 2002 at 11:35:24AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 11:35:24AM -0600, James Bottomley wrote:

> Have there been any published comparisons of a write barrier implementation 
> verses something like the McKusick soft update idea

Soft updates are just another mechanism of doing ordered writes.  If
the disk IO subsystem is lying about write ordering or is doing
unexpected writeback caching, soft updates are no more of a cure than
journaling.

> or even just 
> multi-threaded back end completion of the transactions?

ext3 already does the on-disk transaction complete asynchronously
within a separate kjournald thread, independent of writeback IO going
on in the VM's own writeback threads.  Given that it is kernel code
given full access to the kernel's internal lazy IO completion
mechanisms, I'm not sure that it can usefully be given any more
threading.  I think the reiserfs situation is similar.

--Stephen
