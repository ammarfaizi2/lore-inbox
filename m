Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUBDCti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUBDCti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:49:38 -0500
Received: from ns.suse.de ([195.135.220.2]:12269 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266279AbUBDCth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:49:37 -0500
To: Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver for IBM RSA service processor (1/2)
References: <200402021129.53193.masbock@us.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2004 03:49:35 +0100
In-Reply-To: <200402021129.53193.masbock@us.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73vfmnlfsw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Asbock <masbock@us.ibm.com> writes:
> +
> +#define IBMASM_IOCTL_MAGIC	'f'
> +#define IBMASM_IO_CANCEL	_IO(IBMASM_IOCTL_MAGIC, 0)

Can you please move that into some file in include/linux ?  IMHO all
ioctls should be in some header, otherwise nobody knows you reserved
the number. Note that ioctl numbers must be unique in Linux. Also it
would be good if you added an
register_ioctl32_conversion(IBMASM_IOCTL_MAGIC, sys_ioctl) or an
COMPATIBLE_IOCTL in compat_ioctl.h for it to make it transparently
work with the 32bit emulation layers.

-Andi
