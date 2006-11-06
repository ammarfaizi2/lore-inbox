Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753828AbWKFVgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbWKFVgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbWKFVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:36:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:46834 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753828AbWKFVgL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:36:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Hoang-Nam Ngyuen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control block in 64k page mode
Date: Mon, 6 Nov 2006 22:35:28 +0100
User-Agent: KMail/1.9.5
Cc: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, hnguyen@de.ibm.com, raisch@de.ibm.com
References: <200611062226.44939.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200611062226.44939.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611062235.28667.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 November 2006 22:26, Hoang-Nam Ngyuen wrote:
> -       rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +       rblock = (struct hipz_query_hca*)ehca_alloc_fw_ctrlblock();

>  
> -       rblock = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +       rblock = (struct hipz_query_port*)ehca_alloc_fw_ctrlblock();

The point Heiko made in his comment is that with ehca_alloc_fw_ctrlblock
returning a void*, you can (and _should_) remove the casts to other
pointer types.

	Arnd <><
