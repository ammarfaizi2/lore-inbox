Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWEVBvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWEVBvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWEVBvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:51:41 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:30413 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S964981AbWEVBvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:51:40 -0400
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid
	context'
From: Arjan van de Ven <arjan@infradead.org>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
Content-Type: text/plain
Date: Mon, 22 May 2006 03:51:37 +0200
Message-Id: <1148262697.3902.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 21:36 -0400, Giridhar Pemmasani wrote:
> If __vmalloc is called in atomic context with GFP_ATOMIC flags,
> __get_vm_area_node is called, which calls kmalloc_node with GFP_KERNEL
> flags. This causes 'sleeping function called from invalid context at
> mm/slab.c:2729' with 2.6.16-rc4 kernel. A simple solution is to use
> proper flags in __get_vm_area_node, depending on the context:


vmalloc sleeps, or at least does things to the lower vm layers that
really do sleepy things. So calling it from an atomic context really
tends to be a bug....

where in the kernel is this done?

