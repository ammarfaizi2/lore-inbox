Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCFRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCFRFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWCFRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:05:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:57289
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751271AbWCFRFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:05:50 -0500
Date: Mon, 6 Mar 2006 09:05:42 -0800
From: Greg KH <greg@kroah.com>
To: s.schmidt@avm.de
Cc: kkeil@suse.de, libusb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       opensuse-factory@opensuse.org, torvalds@osdl.org
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060306170542.GB8142@kroah.com>
References: <20060217230004.GA15492@kroah.com> <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:47:43PM +0100, s.schmidt@avm.de wrote:
> Your focus on the technical aspects shows us that there is a common
> understanding, so we certainly appreciate your input.
> 
> The described userland/kernel mix scenarios may work in uninterrupted
> environments, but non-stop quality of service "at all times and situations"
> is only truly feasible in kernel space. "with the only bottleneck being the
> CPU to RAM bus." is exactly the main argument against a mixed kernel/user
> space driver architecture. We know from our everyday business, Linux is
> often used in slow CPU environments like PIII or similar. Thus latency
> times are even more critical within these environments.

I agree.  But have you measured such latency on the 2.6 kernel recently?
On old hardware?  Is it still unacceptable for you?  If so, what is
required?

> Even though people might do realtime DSP things in user space with Linux
> and soft modems might work pretty well in userspace, in the case of Fax G3
> an extremely short latency is required. The user space lacks the required
> reliability and interoperability. Latency times of 4/10/20 or 40
> milliseconds are one aspect, but QoS is the overall essence. Within the
> kernel space there is no need for unnecessary mode switches or data copy
> procedures.

I understand, that is why I suggested a mix of a kernel driver to handle
the stuff that has latency issues, and userspace to handle the rest.

> Compared to other operating systems, such as Mac OS, BeOS,
> Windows etc., Linux is walking a solitary path with the "user mode only"
> shift. One gets the impression, that legal concerns are leading Linux to a
> technically suboptimal/isolated solution.

No, right now, Linux has the best latency numbers _by far_ than any
other operating system, so we can move stuff to userspace.

And again, it's your legal issues that are forcing you that way, if you
change that, putting everything in the kernel would be fine :)

So, in conclusion, is there anything that we can help you out with in
regards to you feeling that userspace can not handle your needs?  Do you
have numbers showing that putting a small portion of the USB urb handler
logic in the kernel and the rest in userspace will not work for you?
Example code showing long delay periods that we can help fix?

Anything else we can do?

thanks,

greg k-h
