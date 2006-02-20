Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWBTSdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWBTSdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWBTSdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:33:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:63714 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161110AbWBTSdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:33:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [openib-general] Re: [PATCH 21/22] ehca main file
Date: Mon, 20 Feb 2006 19:32:31 +0100
User-Agent: KMail/1.9.1
Cc: Anton Blanchard <anton@samba.org>, Roland Dreier <rolandd@cisco.com>,
       SCHICKHJ@de.ibm.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com, linuxppc64-dev@ozlabs.org
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060220152213.GD19895@krispykreme> <43FA7677.3040901@de.ibm.com>
In-Reply-To: <43FA7677.3040901@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200602201932.31739.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 03:09, Heiko J Schick wrote:
>  >>+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12)
>  >>+#define EHCA_RESOURCE_ATTR_H(name)                                         \
>  >>+static ssize_t  ehca_show_##name(struct device *dev,                       \
>  >>+                             struct device_attribute *attr,            \
>  >>+                             char *buf)
>  >>+#else
>  >>+#define EHCA_RESOURCE_ATTR_H(name)                                         \
>  >>+static ssize_t  ehca_show_##name(struct device *dev,                       \
>  >>+                             char *buf)
>  >>+#endif
>  >
>  >
>  > No need for kernel version ifdefs.
> 
> The point is that our module have to run on Linux 2.6.5-7.244 (SuSE SLES 9 SP3), too.
> This was the reason why we've included the ifdefs. We can change the ifdefs to
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(2.6.5) to mark that this code is used for
> Linux 2.6.5 compatibility.

That only makes sense as long as you have a common source code for both
that also is under your control. As soon as the driver enters the mainline
kernel, it is no longer helpful to have these checks in it, because other
people will start making changes to the driver that you don't want to
have in the 2.6.5 version.

You cannot avoid forking the code in the long term, but fortunately the
need to backport fixes to the old version should also decrease over time.

	Arnd <><
