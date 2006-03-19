Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWCSWtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWCSWtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWCSWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:49:45 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:10360 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751163AbWCSWto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:49:44 -0500
X-IronPort-AV: i="4.03,109,1141624800"; 
   d="scan'208"; a="396814938:sNHT29816248"
Date: Sun, 19 Mar 2006 16:49:40 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org,
       mactel-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060319224939.GA712@lists.us.dell.com>
References: <20060319184325.GA7605@srcf.ucam.org> <20060319212901.GA30843@lists.us.dell.com> <20060319213259.GA8602@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319213259.GA8602@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 09:33:01PM +0000, Matthew Garrett wrote:
> On Sun, Mar 19, 2006 at 03:29:01PM -0600, Matt Domsch wrote:
> 
> > NAK.  efibootmgr, the main userspace consumer of this struct, also
> > thinks this is an "unsigned long".
> 
> Hm. My copy of efibootmgr has:
> 
> typedef struct _efi_variable_t {
>         efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
>         efi_guid_t    VendorGuid;
>         uint64_t         DataSize;
>         uint8_t          Data[1024];
>         efi_status_t  Status;
>         uint32_t         Attributes;
> } __attribute__((packed)) efi_variable_t;
> 
> which certainly makes it look like it's expecting a 64-bit value. But 
> checking the spec does seem to suggest that datasize is a native value, 
> so presumably it's an efibootmgr bug rather than a kernel one? In that 
> case, this ought to be dropped.

Sorry, I did mean to post a link to the latest efibootmgr that has
this fixed:

Home page: http://linux.dell.com/efibootmgr/

For distros that care about 32-bit EFI, please upgrade to efibootmgr 0.5.3.
http://linux.dell.com/efibootmgr/efibootmgr-0.5.3.tar.gz
http://linux.dell.com/efibootmgr/efibootmgr-0.5.3.tar.gz.sign
http://linux.dell.com/efibootmgr/ChangeLog

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
