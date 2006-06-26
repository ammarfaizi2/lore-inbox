Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWFZQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWFZQgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFZQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:36:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:17866 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750784AbWFZQgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:36:04 -0400
Date: Mon, 26 Jun 2006 12:35:34 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626163534.GE8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m13bdrvrd4.fsf@ebiederm.dsl.xmission.com> <E717642AF17E744CA95C070CA815AE550E14E4@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE550E14E4@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 11:13:32AM -0500, Miller, Mike (OS Dev) wrote:
> All,
> Sorry to come in late and top post. I've been out of the office and I'm
> trying to get to the gist of this issue.
> Exactly what is the problem? I'm not familiar with kdump so I don't have
> a clue about what's going on. 

Hi Mike,

Kdump is a kernel crash dumping mechanism which is built on top of
kexec on panic functionality.

http://lse.sourceforge.net/kdump/

After a system crash, a second kernel boots from a reserved memory
without going through the BIOS. This second kernel captures the memory
snapshot of the crashed kernel.

Devices are not shutdown after the first kernel crash hence while second
kernel is initializing device might very well be oprational and sending
interrupts. So the moment a driver loads underlying  device might send an
interrupt indicating completion of a command issued from the context of
crashed kernel. Driver does not know anything about it and often crashes
or raises a BUG() as this is anomalous. 

Ideal thing probably would be to soft reset the deivce before going ahead
with rest of the initilization so that device flushes the messages 
issued from the context of the previous kernels and lower the interrupt line.

Hope this gives some context.


> There are a couple of reset features supported by _some_ cciss
> controllers. I'd have to go back to the open spec to see whats in the
> public domain. We're trying to get the open spec updated and more
> complete but we're waiting on the lawyers. :(
> 

Thanks
Vivek
