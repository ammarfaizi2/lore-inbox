Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUIVDKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUIVDKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 23:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIVDKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 23:10:37 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:17583 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267760AbUIVDKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 23:10:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Tue, 21 Sep 2004 22:10:07 -0500
User-Agent: KMail/1.6.2
Cc: "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409210051.36251.dtor_core@ameritech.net> <20040921145150.A27211@unix-os.sc.intel.com>
In-Reply-To: <20040921145150.A27211@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409212210.07580.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 04:51 pm, Keshavamurthy Anil S wrote:
> On Tue, Sep 21, 2004 at 12:51:36AM -0500, Dmitry Torokhov wrote:
> > On Monday 20 September 2004 08:38 pm, Keshavamurthy Anil S wrote:
> > > Currently I am handling both the surprise removal and the eject request in the same
> > > way, i,e send the notification to the userland and the usermode agent scripts
> > > is responsible for offlining of all the devices and then echoing onto eject file.
> > > 
> > 
> > I actually think that on the highest level we should treat controlled and
> > surprise ejects differently. With controlled ejects the system (kernel +
> > userspace) can abort the sequence if something goes wrong while with surprise
> > eject the device is physically gone. Even if driver refuses to detach or we
> > have partition still mounted or something else if physical device is gone we
> > don't have any choice except for trimming the tree and doing whatever we need
> > to do.
> 
> I agree, but when dealing with devices like CPU and Memory, not sure how the
> rest of the Operating System handles surprise removal. For now I will go ahead and
> add a PRINTK saying that BUS_CHECK(surprise removal request) was received in the 
> ACPI Processor and in the container driver, and when we hit that printk on a 
> real hardware, I believe it would be the right time then to see how the OS behaves 
> and do the right code then. For Now I will just go ahead and add a PRINTK.
>

Heh, I really don't expect the kernel to survive if somebody just yanks out a
CPU without a warning, especially if the CPU is the last one :) I hand in mind
devices like my port replicator that only has an additional network card and
could survive surprise removal.

> Let me know if this step by step approach is okay to you.

It sure is, we can always adjust the process down the road.

Thank you for your work!

-- 
Dmitry
