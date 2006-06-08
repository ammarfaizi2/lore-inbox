Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWFHAuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWFHAuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWFHAuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:50:22 -0400
Received: from mga07.intel.com ([143.182.124.22]:31271 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932517AbWFHAuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:50:21 -0400
X-IronPort-AV: i="4.05,218,1146466800"; 
   d="scan'208"; a="47693905:sNHT165425099"
Date: Wed, 7 Jun 2006 17:46:31 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Brendan Trotter <btrotter@gmail.com>
Cc: Keith Owens <kaos@sgi.com>, Andi Kleen <ak@suse.de>,
       Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons
Message-ID: <20060607174630.B27195@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200606070920.23436.ak@suse.de> <8446.1149666227@kao2.melbourne.sgi.com> <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com>; from btrotter@gmail.com on Wed, Jun 07, 2006 at 03:18:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 03:18:57PM +0000, Brendan Trotter wrote:
> Hi,
> 
> On 6/7/06, Keith Owens <kaos@sgi.com> wrote:
> > This problem is not KDB specific, although that is where it was first
> > noticed.  Any code that sends a broadcast IPI 2 or an NMI IPI will
> > crash these Dell boxes when there is a mismatch between the cpus known
> > to the BIOS and the cpus known to the OS.
> 
> I missed this (broadcast IPI 2 causing problems)...
> 
> Before the OS starts all AP CPUs should be in a special halt state
> (specifically "cli; hlt"), where the only interrupt sources that reach
> the CPU are NMI, SMI and INIT. This is why broadcast NMI is unsafe for
> a variety of reasons (not just on Dells).
> 
> If the Dell machines allow an IPI 2 to get through then unused CPUs
> aren't in the "cli; hlt" state, and they would also respond to any
> other broadcast IPIs. This would imply that any code that uses
> send_IPI_allbutself(), send_IPI_all() or anything else that sends
> broadcast IPIs would/could cause problems on these Dell machines.

The other possibility is that these CPUs are in the cli;hlt state,
but BIOS didn't install a proper NMI handler for them. This would
explain why other "normal" broadcast IPIs didn't cause problems
while NMI broadcast killed the machine.

Rajesh
