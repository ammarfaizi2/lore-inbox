Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965579AbVKGXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965579AbVKGXPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965589AbVKGXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:15:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965579AbVKGXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:15:41 -0500
Date: Mon, 7 Nov 2005 15:15:24 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: tzachar@cs.bgu.ac.il, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI and PRREMPT bug
Message-ID: <20051107231524.GW7991@shell0.pdx.osdl.net>
References: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E0356B628@orsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Moore, Robert (robert.moore@intel.com) wrote:
> You might try setting this flag (in acglobal.h) to TRUE:
> 
> /*
>  * Automatically serialize ALL control methods? Default is FALSE,
> meaning
>  * to use the Serialized/NotSerialized method flags on a per method
> basis.
>  * Only change this if the ASL code is poorly written and cannot handle
>  * reentrancy even though methods are marked "NotSerialized".
>  */
> ACPI_EXTERN UINT8       ACPI_INIT_GLOBAL (AcpiGbl_AllMethodsSerialized,
> FALSE);

I've chatted with another person having this issue.  Booting with
acpi_serialize (which sets that flag to true) does seem to fix the
problem.  I'm guessing thread_count gets decremented twice for one
increment, causing it to underflow wrapping to -1.

thanks,
-chris
