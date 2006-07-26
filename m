Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWGZQLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWGZQLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWGZQLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:11:13 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59305 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750965AbWGZQLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:11:12 -0400
Date: Wed, 26 Jul 2006 12:10:55 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: Re: [PATCH 2/2] usbhid: HID device simple driver interface
Message-ID: <20060726161055.GB28284@filer.fsl.cs.sunysb.edu>
References: <44C746F1.6090601@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C746F1.6090601@ccoss.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 06:41:53PM +0800, liyu wrote:
> ==================================
> HID device simple driver interface
> ==================================
>  
>     This patch include the header file for this API.
> 
>     I am sorry for sendding patches in the attachment, beacause of my
> mail client always break TAB into some spaces.
> 
>     Good luck.
> 
> -Liyu
> 

First of all, you should include your patches inline. That way one can
easily comment on them. I only quickly glanced at it, and I am not sure
about why you need the additional list_ macros. Also, several of your macros
do something like this:

+#define hidinput_simple_driver_setup_usage(hid) \
+do {\
+       if (hid->simple) {\
+               hid->simple->flags |= HIDINPUT_SIMPLE_SETUP_USAGE; \
+               hidinput_simple_driver_configure_usage(hid); \
+       }\
+} while (0)

You should use (hid) instead of hid. Because of how the pre-processor works.

Josef "Jeff" Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
