Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUDUHFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUDUHFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUDUHFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:05:46 -0400
Received: from fmr11.intel.com ([192.55.52.31]:53142 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265124AbUDUHFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:05:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] add some EFI device smarts
Date: Wed, 21 Apr 2004 00:05:33 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEA99@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] add some EFI device smarts
Thread-Index: AcQnMol3pheYFlLSSfOiU/pUuMD94QAOmrgw
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2004 07:05:34.0044 (UTC) FILETIME=[0A4629C0:01C4276F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Apr 20, 2004 at 04:00:26PM -0600, Bjorn Helgaas wrote:
> > (Like much of the EFI stuff, this really isn't ia64-specific.  Maybe
> > it's time to move some of it under drivers/efi?  If there's 
> interest,
> > I can look at doing that.)
> 
> Matt T. had done the work to move it under drivers/efi, though now
> that there's a drivers/firmware, that's more appropraite.  It also
> converted it to use sysfs instead of proc.  There was a bug in
> efivars_exit() where it was removing stuff (which could sleep) while
> holding a spinlock which wasn't good, but that was about the only
> issue anyone had with it.

Indeed.  I fixed that and one other small issue Greg pointed out
a while ago.  I'll resend updated efivars driver patches in a separate
mail shortly.   

> +int
> +efi_get_variable(char *name, efi_variable_t *guid, unsigned 
> char *data, unsigned long *size)
> 
> and do a guidcmp() on them as well as the strcmp() on the name.
> 
> > +int __init
> > +efi_uart_console_only(void)
> 
> So to be useful, efivars can't be build modular anymore, right?  Then
> Kconfig needs to change as well.  It's module_init(), is that early
> enough to be used?  Where is efi_uart_console_only() called from?
> It's not in this patch.

This part isn't clear to me.  It looks like you are including a 
duplicate efi_get_variable function in efi.c in order to have 
access to EFI variable services (and perform the checks) very early 
before console initialization and/or efivars is available ... is 
that correct?    

thanks,
matt
