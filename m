Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUJAPGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUJAPGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUJAPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:05:50 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:11472 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S263736AbUJAPFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:05:07 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.9rc2-mm4 oops
Date: Fri, 1 Oct 2004 09:04:52 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       Bernhard Rosenkraenzer <bero@arklinux.org>
References: <1096571653.11298.163.camel@cmn37.stanford.edu> <200409301704.28573.bjorn.helgaas@hp.com> <1096594616.11297.688.camel@cmn37.stanford.edu>
In-Reply-To: <1096594616.11297.688.camel@cmn37.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410010904.52892.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 7:36 pm, Fernando Pablo Lopez-Lezcano wrote:
> On Thu, 2004-09-30 at 16:04, Bjorn Helgaas wrote:
> > Like Pierre, I was able to reproduce this with DEBUG_PAGEALLOC.
> > I found a struct acpi_driver in hpet.c that was erroneously marked
> > __init, and the attached patch fixed the oops for me.  Can you give
> > this a whirl?
> 
> Sorry, I did, and still get the oops. This is it this time (looks the
> same to me):
> 
> inserting floppy driver for 2.6.8.1-1.520.1nov.rhfc2.ccrma
> Unable to handle kernel paging request at virtual address f8881920

Can you post your .config?  If you don't have CONFIG_HPET turned
on, my patch wouldn't help.  Also, can you look up the bad address
(e.g., f8881920) in /proc/kallsyms?  When I reproduced it, the
faulting address was hpet_acpi_driver.  Maybe you've found a
similar bug in a different driver.

