Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbUKLSf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUKLSf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUKLSf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:35:57 -0500
Received: from colo.lackof.org ([198.49.126.79]:4015 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262603AbUKLSfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:35:50 -0500
Date: Fri, 12 Nov 2004 11:35:47 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041112183547.GA8828@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D84972020F3C99@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3C99@NT-IRVA-0741.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 09:52:17AM -0800, Michael Chan wrote:
> On Wednesday, November 10, 2004 11:58 PM Andi Kleen wrote:
> > Where is it guaranteed that these writes are non posted?
> 
> Intel chipset engineer confirmed that they are non-posted.

Michael,
Thanks for digging that up.
I think Andi was looking for references to the PCI-E spec.
I found such a statement in "PCI Express(TM) Base Specification
Revision 1.0a".

Table 2-3 on page 47 says:
| Cpl 00 0 1010 Completion without Data ­ Used for I/O and
|               Configuration Write Completions and Read
|               Completions (I/O, Configuration, or
|               Memory) with Completion Status other than
|               Successful Completion.

Section "2.2. Transaction Layer Protocol - Packet Definition"
| Transactions are carried using Requests and Completions. Completions
| are used only where required, for example, to return read data, or
| to acknowledge Completion of I/O and Configuration Write Transactions.
| Completions are associated with their corresponding Requests by the value
| in the Transaction ID field of the Packet header.

And "2.6.1 Flow Control Rules":
| Flow Control distinguishes three types of TLPs (note relationship
| to ordering rules ­ see Section 2.4):
| ·   Posted Requests (P) ­ Messages and Memory Writes
| ·   Non-Posted Requests (NP) ­ All Reads, I/O, and Configuration Writes
| ·   Completions (CPL) ­ Associated with corresponding NP Requests


hth,
grant
