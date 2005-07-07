Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVGGSxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVGGSxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGGSv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:51:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59791 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261540AbVGGSvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:51:10 -0400
Date: Thu, 7 Jul 2005 20:52:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: "'Clemens Koller'" <clemens.koller@anagramm.de>,
       "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>, hdaps-devel@lists.sourceforge.net,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707185223.GC29449@suse.de>
References: <42CD600C.2000105@anagramm.de> <002401c58317$865ee6a0$600cc60a@amer.sykes.com> <002401c58317$865ee6a0$600cc60a@amer.sykes.com> <20050707173412.GL24401@suse.de> <E1DqaUl-0003qg-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DqaUl-0003qg-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Matthew Garrett wrote:
> Jens Axboe <axboe@suse.de> wrote:
> 
> > What is needed is to flesh out what the kernel interface should looke
> > like. I suggested a sysfs file for suspending and resuming access to the
> > device, if people have other ideas they should voice them.
> 
> That sounds quite reasonable. Does it need to do anything other than
> park the head and suspend the command queue for that device?

Not really, no. Someone mentioned a timeout for this as well, but I
think that should just be done in user space.

> (On an only slightly related note, for full ACPI support of PATA, we're
> supposed to use the _GTF interface. This returns a set of taskfile
> commands that are then supposed to be executed by the host. However, at
> the point where we want to do this, the IDE queues haven't been
> restarted. Is the best solution here just to add a trivial and stupid
> IDE driver for managing the disks when we don't want userspace doing
> anything with them?)

Either that, or always allow non-fs commands to go through a frozen
queue. Or flag those commands as ok for a frozen queue. The advantage of
either of those approaches, is that we probably don't have to add any
kernel support then and the generic block device freezing/unfreezing can
be used.

-- 
Jens Axboe

