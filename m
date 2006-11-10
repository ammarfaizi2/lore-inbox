Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424382AbWKJIqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424382AbWKJIqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424383AbWKJIqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:46:17 -0500
Received: from ozlabs.org ([203.10.76.45]:45742 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1424382AbWKJIqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:46:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17748.15442.906060.210242@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 19:46:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: "Roland Dreier" <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org,
       openib-general-bounces@openib.org
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
 mapping in 64k page mode
In-Reply-To: <OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
References: <adaodrgb7uq.fsf@cisco.com>
	<OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Raisch writes:

> The patch is needed. We've seen it on the real system. We did fix it on the
> real system.

I disagree that the ioremap change is needed.

> ...and it conforms to theory... although theory is a bit confusing here.
> 
> let me try to summarize:
> ioremap checks for 64k boundary (actually page boundary)

Actually, ioremap itself already does the calculations that your patch
adds - that is, it generates the offset within the page and the
physical address of the start of the page, does the mapping using the
latter, then adds on the offset to the virtual address of the page and
returns that.

Paul.
