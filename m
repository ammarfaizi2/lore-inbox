Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756308AbWKVSXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbWKVSXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbWKVSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:23:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7588 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756308AbWKVSXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:23:04 -0500
Date: Wed, 22 Nov 2006 18:29:14 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: <pledr@t-online.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mapping of pages out of upper 128MB into kernel address space
Message-ID: <20061122182914.360752ef@localhost.localdomain>
In-Reply-To: <1GmwSV-2BnPRg0@fwd32.sul.t-online.de>
References: <1GmwSV-2BnPRg0@fwd32.sul.t-online.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Nov 2006 18:05 GMT
<pledr@t-online.de> wrote:

> Hi,
> in a kernel module I have to translate user addresses into kernel addresses. The user uses shared memory allocated with shm_open / ftruncate. This shared memory is allocated somewhere in the upmost 128MB of physical memory that is NOT permanently mapped into the kernel ( found in swapper_pg_dir ). How can I "smp_save" map this memory into the kernel address space ?

See how copy_highpage and friends are used by copy_to/from_user. The
kmaps are a limited resource so you can only really use them to briefly
map objects in this way.

Alan
