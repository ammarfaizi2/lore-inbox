Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTLKIHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLKIHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:07:21 -0500
Received: from ns.suse.de ([195.135.220.2]:43177 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264375AbTLKIHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:07:20 -0500
Date: Thu, 11 Dec 2003 09:07:16 +0100
From: Andi Kleen <ak@suse.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: menage@google.com, agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
Message-Id: <20031211090716.0c3662d3.ak@suse.de>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 15:06:10 +0800
"Yu, Luming" <luming.yu@intel.com> wrote:

> 
> Above code have a bug! Considering below code:
> 
> u8	acquired = FALSE;
> 
> ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
> if(acquired) {
> ....
> }
> 
> Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
> complain that  too !

It has even more bugs, e.g. it doesn't tell gcc that GLptr is modified (this hurts with
newer versions that optimize more aggressively) 

I tried to fix it on x86-64, but eventually gave up and adopted the IA64 C version.

-Andi

