Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTLDDlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTLDDlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:41:36 -0500
Received: from fmr06.intel.com ([134.134.136.7]:18598 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262356AbTLDDlf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:41:35 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: memory hotremove prototype, take 3
Date: Wed, 3 Dec 2003 09:57:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F4FAEF6@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: memory hotremove prototype, take 3
Thread-Index: AcO5OVp9zk1fsPFaQmak6sj8vKu9eQAI1GygABpaXGA=
From: "Luck, Tony" <tony.luck@intel.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "Yasunori Goto" <ygoto@fsw.fujitsu.com>, "Pavel Machek" <pavel@suse.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 03 Dec 2003 17:57:21.0577 (UTC) FILETIME=[E6592190:01C3B9C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IMHO, To hot-remove memory, memory attribute should be divided
> > into Hotpluggable and no-Hotpluggable, and each attribute memory
> > should be allocated each unit(ex. node).
> 
> Why? I still don't get that -- we should be able to use the virtual
> addressing mechanism of any CPU to swap under the rug any virtual
> address without needing to do anything more than allocate a page frame
> for the new physical location (I am ignoring here devices that are 
> directly accessing physical memory--a callback in the device 
> model could
> be added to require them to reallocate their buffers).
> 
> Or am I deadly and naively wrong?

Most (all?) Linux implementations make use of a large area
of memory that is mapped 1:1 (with a constant offset) from
kernel virtual space to physical space.  Kernel memory is
allocated in this virtual area.  If the processor supports
some form of large pages in the TLB, this 1:1 area uses the
large pages ... so it would require some major surgery to
remap portions of this area, and would have a negative effect
on performance (since you'd take more TLB misses).  It might
even be a correctness issue if the structures in this area
were needed to handle small page TLB faults in the area itself.

-Tony
