Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSKQXhI>; Sun, 17 Nov 2002 18:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSKQXhI>; Sun, 17 Nov 2002 18:37:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9640 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266998AbSKQXhG>; Sun, 17 Nov 2002 18:37:06 -0500
Date: Sun, 17 Nov 2002 18:45:09 -0500
From: Doug Ledford <dledford@redhat.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Why /dev/sdc1 doesn't show up...
Message-ID: <20021117234509.GL3280@redhat.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20021117195258.GC3280@redhat.com> <20021117232004.GA1779@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021117232004.GA1779@win.tue.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 12:20:04AM +0100, Andries Brouwer wrote:
> On Sun, Nov 17, 2002 at 02:52:58PM -0500, Doug Ledford wrote:
> 
> > Working on a fix.  Haven't decided how to do it yet.
> 
> I encountered similar phenomena with usb-storage.
> I think the proper solution is to never automatically
> scan for a partition table.

Scanning for a partition table is just one aspect.  In general, once a 
module has handed over it's entry points to some other kernel area those 
entry points should be ready for use, so blocking access to them isn't 
needed.  OTOH, when you are tearing a module down then you do want access 
to stop, so that's the proper time to set live == 0.

> We perhaps need to do that at boot time, but in all other
> cases user space can ask the kernel to read a partition table.

(When it works, which it currently doesn't for me in latest bk)

> For usb-storage things work fairly well (for some kernels)
> using
> 	blockdev --rereadpt /dev/sdx

Yeah, that's fine for hotplug.  But, you know what, for PCI hotplug scsi 
this wouldn't even be an issue since a true hot plug event normally would 
be after module init is complete and scanning the table wouldn't be a 
problem then because module->live would be non-0 ;-)

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
