Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268098AbTGOOYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbTGOOYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:24:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2574 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268098AbTGOOYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:24:34 -0400
Date: Tue, 15 Jul 2003 15:39:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>, David Jones <davej@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Message-ID: <20030715153916.B14491@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	David Jones <davej@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@suse.cz>, John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030715085622.A32119@flint.arm.linux.org.uk> <200307151734.46616.mflt1@micrologica.com.hk> <200307151842.19851.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307151842.19851.mflt1@micrologica.com.hk>; from mflt1@micrologica.com.hk on Tue, Jul 15, 2003 at 06:42:17PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:42:17PM +0800, Michael Frank wrote:
> On Tuesday 15 July 2003 17:34, Michael Frank wrote:
> > Jul 15 17:05:00 mhfl2 kernel: Suspending devices
> > Jul 15 17:05:00 mhfl2 kernel: Yenta: dev suspend
> > Jul 15 17:05:00 mhfl2 kernel: Yenta: suspend saved state ff
> > Jul 15 17:05:00 mhfl2 kernel: /critical section: Counting pages to
> > copy[nosave c03e2000] (pages needed: 3426+512=3938 free: 57849) Jul 15
> > 17:05:00 mhfl2 kernel: Alloc pagedir
> > Jul 15 17:05:00 mhfl2 kernel: ....[nosave c03e2000]Enabling SEP on CPU 0
> > Jul 15 17:05:00 mhfl2 kernel: Freeing prev allocated pagedir
> >
> > power down - resume
> >
> > Jul 15 17:05:00 mhfl2 kernel: Yenta: dev resume
> 
> Dev resume ahead of socket resume?

Yes, the dev resume triggers the per-socket resume.

> > Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored state ff
> > Jul 15 17:05:00 mhfl2 kernel: Trying to free nonexistent resource
> > <000003f8-000003ff> Jul 15 17:05:00 mhfl2 kernel: Yenta: init restored
> > state ff
> > Jul 15 17:05:00 mhfl2 kernel: hda: Wakeup request inited, waiting for
> > !BSY... Jul 15 17:05:00 mhfl2 kernel: hda: start_power_step(step: 1000)
> > Jul 15 17:05:00 mhfl2 kernel: hda: completing PM request, resume
> > Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
> > Jul 15 17:05:01 mhfl2 kernel: Devices Resumed
> > Jul 15 17:05:01 mhfl2 kernel: Yenta: dev resume
> 
> One more dev resume

The extra resume is caused by not having all the PM information available
to PCI device drivers.  This is probably another bit of the PM interface
which needs to be fixed for 2.6.0.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

