Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWIONAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWIONAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWIONAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:00:23 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:47008 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751365AbWIONAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:00:22 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=onj6V6ha/Q49nUw5Ku8Hjd10SclycFxYXZjaqVVdYJrsPfh3IUgW+Flpz6UBt1ydNIv5tGPmG1rEG6I49L/MxBLMqs9nUNtCcV6z6bE5FycoF8VyH71ps5WH2j4X2jOH;
X-IronPort-AV: i="4.09,170,1157346000"; 
   d="scan'208"; a="80803624:sNHT16909857"
Date: Fri, 15 Sep 2006 07:59:14 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Bug ??] 2.6.18-rc6-mm2 - PCI ethernet board does not seem to work
Message-ID: <20060915125914.GA1201@lists.us.dell.com>
References: <450A7EC5.2090909@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450A7EC5.2090909@bull.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:21:57PM +0200, Pierre Peiffer wrote:
> Hi,
> 
> My Ethernet board (Intel(R) PRO/1000) "doesn't seems" to work any more
> with this kernel, but all is ok with kernel 2.6.18-rc6-mm1.
> 
> A bisection search show this patch:
> gregkh-pci-pci-sort-device-lists-breadth-first.patch
> as being the faulty one...
> 
> But after reading the content of this patch, I understood that the order
> of the ethernet boards had changed. In fact,  I have four ethernet
> boards and now, my eth0 does not point on the same card...
> So all is now ok by changing my cable to the right board.
> 
> But is this really the expected behavior ?

Yes, it's expected, but no, I agree it would be nice to not break
existing setups.

Care to send me an output of 'lspci -tv' and dmidecode (the first 80
or so lines)?

I think I'll redo this patch to keep the 2.6 depth-first sort order as
default, with command line options "pci=bfsort" and "pci=nobfsort" to
force it one way or the other, and DMI table entries for Dell's newest
systems that should default to bfsort.

Pierre, thank you for you report and your time to do the bisect.  I
apologize for any inconvenience this caused you.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
