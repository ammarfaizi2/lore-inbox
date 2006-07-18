Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWGRWhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWGRWhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWGRWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:37:55 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:29387 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932279AbWGRWhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:37:55 -0400
To: Dave Jones <davej@redhat.com>
Cc: Thomas Dillig <tdillig@stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
References: <44BC5A3F.2080005@stanford.edu>
	<20060718164023.GA29417@redhat.com>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Jul 2006 00:37:33 +0200
In-Reply-To: <20060718164023.GA29417@redhat.com>
Message-ID: <m3lkqqv8sy.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Mon, Jul 17, 2006 at 08:49:19PM -0700, Thomas Dillig wrote:
> 
>  > 144 drivers/char/agp/ati-agp.c
>  > NULL dereference of variable "ati_generic_private.gatt_pages" in 
>  > function call (drivers/char/agp/ati-agp.c:ati_free_gatt_pages).
>  
> I think this is a false positive.

I don't think so. If the 'entry = kzalloc(...)' fails at line 125, the
code will set tables to NULL and retval to != 0. ati_free_gatt_pages()
will then be called with .gatt_pages == NULL and .num_tables > 0. This
will trigger a NULL pointer dereference in ati_free_gatt_pages().

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
