Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVGKATh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVGKATh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVGKARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:17:37 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10458 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262073AbVGKAQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:16:07 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C030A908F@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org
Subject: RE: [PATCH 22/82] remove linux/version.h from drivers/message/fus
	ion
Date: Sun, 10 Jul 2005 18:15:43 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather you not kill linux_compat.h file.
I use this file for compatibility of driver source 
across various kernel versions.  I provide our
customers with driver builds containing single source 
which needs to compile in kernels 2.6.5( e.g. SLES9),
2.6.8 (e.g. RHEL4), and 2.6.11 ( e.g. SuSE 9.3 Pro).

If you look at our 3.02.18 driver source I submitted to SuSE
for SLES9 SP2, you will see this file is about 3K bytes of
compatibility.  

Eric Moore
LSI Logic Corporation 


On Sunday, July 10, 2005 1:36 PM, Olaf Hering wrote:
> 
> 
> changing CONFIG_LOCALVERSION rebuilds too much, for no 
> appearent reason.
> 
> remove also drivers/message/fusion/linux_compat.h,
> because it is empty after the change
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> drivers/message/fusion/linux_compat.h |   18 ------------------
> drivers/message/fusion/mptbase.c      |    1 -
> drivers/message/fusion/mptbase.h      |    1 -
> drivers/message/fusion/mptctl.c       |    1 -
> drivers/message/fusion/mptctl.h       |    1 -
> drivers/message/fusion/mptfc.c        |    1 -
> drivers/message/fusion/mptlan.h       |    1 -
> drivers/message/fusion/mptscsih.c     |    1 -
> drivers/message/fusion/mptspi.c       |    1 -
> 9 files changed, 26 deletions(-)
> 
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/linux_compat.h
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/linux_compat.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* drivers/message/fusion/linux_compat.h */
> -
> -#ifndef FUSION_LINUX_COMPAT_H
> -#define FUSION_LINUX_COMPAT_H
> -
> -#include <linux/version.h>
> -#include <scsi/scsi_device.h>
> -
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> -static int inline scsi_device_online(struct scsi_device *sdev)
> -{
> -	return sdev->online;
> -}
> -#endif
> -
> -
> -/*}-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> -=-=-=-=-=-=-=-=*/
> -#endif /* _LINUX_COMPAT_H */
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptbase.c
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.c
> @@ -47,7 +47,6 @@
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> #include <linux/config.h>
> -#include <linux/version.h>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/errno.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.h
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptbase.h
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.h
> @@ -49,7 +49,6 @@
> #define MPTBASE_H_INCLUDED
> /*{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> -#include <linux/version.h>
> #include <linux/config.h>
> #include <linux/kernel.h>
> #include <linux/pci.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptctl.c
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.c
> @@ -45,7 +45,6 @@
> */
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> -#include <linux/version.h>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/errno.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.h
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptctl.h
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.h
> @@ -49,7 +49,6 @@
> #define MPTCTL_H_INCLUDED
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> -#include "linux/version.h"
> 
> 
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptlan.h
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptlan.h
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptlan.h
> @@ -66,7 +66,6 @@
> #include <linux/slab.h>
> #include <linux/miscdevice.h>
> #include <linux/spinlock.h>
> -#include <linux/version.h>
> #include <linux/workqueue.h>
> #include <linux/delay.h>
> // #include <linux/trdevice.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptfc.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptfc.c
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptfc.c
> @@ -43,7 +43,6 @@
> Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
> 02111-1307  USA
> */
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> -#include "linux_compat.h"	/* linux-2.6 tweaks */
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptscsih.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptscsih.c
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptscsih.c
> @@ -44,7 +44,6 @@
> */
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> -#include "linux_compat.h"	/* linux-2.6 tweaks */
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptspi.c
> ===================================================================
> --- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptspi.c
> +++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptspi.c
> @@ -44,7 +44,6 @@
> */
> /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> =-=-=-=-=-=-=-=*/
> 
> -#include "linux_compat.h"	/* linux-2.6 tweaks */
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> 
