Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVADMge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVADMge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVADMge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:36:34 -0500
Received: from [213.85.13.118] ([213.85.13.118]:52096 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261489AbVADMgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:36:31 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] mm: overcommit updates
References: <200501040611.j046BHoq005158@hera.kernel.org>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Tue, 04 Jan 2005 15:36:11 +0300
In-Reply-To: <200501040611.j046BHoq005158@hera.kernel.org> (Linux Kernel
 Mailing List's message of "Tue, 04 Jan 2005 04:15:37 +0000")
Message-ID: <m14qhxmkw4.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List <linux-kernel@vger.kernel.org> writes:

> ChangeSet 1.2136.3.17, 2005/01/03 20:15:37-08:00, Andries.Brouwer@cwi.nl
>

[...]

>  
> +	/* Leave the last 3% for root */
> +	if (current->euid)
> +		allowed -= allowed / 32;

This results in

	/*
	 * Leave the last 3% for root
	 */
	if (!capable(CAP_SYS_ADMIN))
		allowed -= allowed / 32;
	allowed += total_swap_pages;

	/* Leave the last 3% for root */
	if (current->euid)
		allowed -= allowed / 32;

in security/commoncaps.c (and similarly in security/dummy.c). Why
"super-user" reservation is handled twice, and with that antiquated
current->euid check instead of capabilities? Broken merge?

On another account, shouldn't capable(CAP_SYS_ADMIN) checks in
cap_vm_enough_memory() be replaced with capable(CAP_SYS_RESOURCE):
(CAP_SYS_RESOURCE is used by file systems to control reserved disk
blocks)?

Nikita.
