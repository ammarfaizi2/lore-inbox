Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbUJ0UYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUJ0UYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUJ0UUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:20:22 -0400
Received: from fmr03.intel.com ([143.183.121.5]:52621 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262676AbUJ0URd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:17:33 -0400
Date: Wed, 27 Oct 2004 13:14:27 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       greg@kroah.com, Pavel Machek <pavel@suse.cz>
Subject: Re: [Proposal]Another way to save/restore PCI config space for suspend/resume
Message-ID: <20041027131427.C2382@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>; from shaohua.li@intel.com on Tue, Oct 26, 2004 at 12:50:57PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 12:50:57PM +0800, Li Shaohua wrote:
> Hi,
> We suffer from PCI config space issue for a long time, which causes many
> system can't correctly resume. Current Linux mechanism isn't sufficient.
> Here is a another idea: 
> Record all PCI writes in Linux kernel, and redo all the write after
> resume in order. The idea assumes Firmware will restore all PCI config
> space to the boot time state, which is true at least for IA32.
> 
A large percentage of them may be irrelevant with respect to 
suspend/resume (e.g. pci device tree and resource scan...).  Apart 
from the performance problems, generic code doing device specific 
config accesses may have correctness problems. For example, you 
will not be able to capture/replay config cycles or other device 
specific initialization (e.g. using memory mapped IO) that BIOS may 
have done before boot. This may be required for correct access to
device specific areas. The same thing is true about device specific 
config accesses that may have been done by the corresponding 
driver after boot. Without device specific knowledge, we may see 
unpredictable behavior and non-repeatable and hard to debug problems.

I don't see how generic code can do the right thing for device
specific accesses. Devices like p2p bridges that have standard
definitions can be handled separately.

Rajesh

