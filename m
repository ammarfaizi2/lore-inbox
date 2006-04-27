Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWD0LHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWD0LHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWD0LHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:07:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35762 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932452AbWD0LHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:07:39 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 01/16] ehca: integration in Linux =?iso-8859-1?q?kernel=09build?= system
Date: Thu, 27 Apr 2006 13:07:36 +0200
User-Agent: KMail/1.9.1
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Marcus Eder <MEDER@de.ibm.com>,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
References: <4450B384.4020601@de.ibm.com>
In-Reply-To: <4450B384.4020601@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604271307.36987.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 14:05, Heiko J Schick wrote:
> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 

Missing any description whatsoever.

> 
>   Kconfig  |    6 ++++++
>   Makefile |   29 +++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 

It would be more practical to put this patch last instead of
first so you don't break the build system with partial applies.

> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig    1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig 2006-01-04 16:29:05.000000000 +0100
> @@ -0,0 +1,6 @@
> +config INFINIBAND_EHCA
> +       tristate "eHCA support"
> +       depends on IBMEBUS && INFINIBAND
> +       ---help---
> +       This is a low level device driver for the IBM
> +       GX based Host channel adapters (HCAs)
> \ No newline at end of file
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile   1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile        2006-03-06 12:26:36.000000000 +0100
> @@ -0,0 +1,29 @@
> +#  Authors: Heiko J Schick <schickhj@de.ibm.com>
> +#           Christoph Raisch <raisch@de.ibm.com>
> +#
> +#  Copyright (c) 2005 IBM Corporation
> +#
> +#  All rights reserved.
> +#
> +#  This source code is distributed under a dual license of GPL v2.0 and OpenIB BSD.
> +
> +obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o
> +
> +hcad_mod-objs = ehca_main.o   \
> +               ehca_hca.o    \
> +               ehca_mcast.o  \
> +               ehca_pd.o     \
> +               ehca_av.o     \
> +               ehca_eq.o     \
> +               ehca_cq.o     \
> +               ehca_qp.o     \
> +               ehca_sqp.o    \
> +               ehca_mrmw.o   \
> +               ehca_reqs.o   \
> +               ehca_irq.o    \
> +               ehca_uverbs.o \
> +               hcp_if.o      \
> +               hcp_phyp.o    \
> +               ipz_pt_fn.o
> +
> +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
> 
Do these need to be on the command line? If you always set them
anyways, you can probably get rid of the #ifdef checking for them.
If you want to keep the code for some reason, it might be better
to have a CONFIG_EHCA_USE_HCALL symbol that is set unconditionally
from Kconfig.

	Arnd <><
