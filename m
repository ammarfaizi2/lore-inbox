Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKSBzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKSBzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUKSByQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:54:16 -0500
Received: from fmr20.intel.com ([134.134.136.19]:55211 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261231AbUKSBw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:52:27 -0500
Subject: Re: [PATCH]Teach drivers don't call may-sleep routines in resume
	code
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1100660643.7466.9.camel@sli10-desk.sh.intel.com>
References: <1100660643.7466.9.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1100828780.18583.5.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 09:46:20 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 11:04, Li Shaohua wrote:
> Hi,
> We already found one driver (PCI link device driver) does the odd thing, so alert other drivers.
> 
> Thanks,
> Shaohua
> 
> --- 2.6/Documentation/power/devices.txt.orig	2004-11-17 10:42:25.160212832 +0800
> +++ 2.6/Documentation/power/devices.txt	2004-11-17 10:46:11.070869192 +0800
> @@ -70,6 +70,9 @@ System devices will only be suspended wi
>  after all other devices have been suspended. On resume, they will be
>  resumed before any other devices, and also with interrupts disabled.
>  
> +*CAUTION*: The resume methods of drivers (normal devices and system devices)
> +should never use any may-sleep methods, since when resume from memory (S3),
> +no task is running.
Oops, the description isn't precise. Some may-sleep routines such as
waiting a sempahore are ok in resume routines, but some (kmalloc) are
bad. Please ignore it till I get a precise description.

Thanks,
Shaohua

