Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWCSVgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWCSVgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWCSVgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:36:11 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:11442 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751025AbWCSVgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:36:10 -0500
Date: Sun, 19 Mar 2006 21:33:01 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org,
       mactel-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] - make sure that EFI variable data size is always 64 bit
Message-ID: <20060319213259.GA8602@srcf.ucam.org>
References: <20060319184325.GA7605@srcf.ucam.org> <20060319212901.GA30843@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319212901.GA30843@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 03:29:01PM -0600, Matt Domsch wrote:

> NAK.  efibootmgr, the main userspace consumer of this struct, also
> thinks this is an "unsigned long".

Hm. My copy of efibootmgr has:

typedef struct _efi_variable_t {
        efi_char16_t  VariableName[1024/sizeof(efi_char16_t)];
        efi_guid_t    VendorGuid;
        uint64_t         DataSize;
        uint8_t          Data[1024];
        efi_status_t  Status;
        uint32_t         Attributes;
} __attribute__((packed)) efi_variable_t;

which certainly makes it look like it's expecting a 64-bit value. But 
checking the spec does seem to suggest that datasize is a native value, 
so presumably it's an efibootmgr bug rather than a kernel one? In that 
case, this ought to be dropped.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
