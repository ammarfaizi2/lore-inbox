Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263242AbVAGAEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbVAGAEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVAGAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:00:02 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:44176 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263119AbVAFXzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:55:40 -0500
Date: Fri, 07 Jan 2005 08:55:37 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] Yet another crash dump tool
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1y8f7nn75.fsf@ebiederm.dsl.xmission.com>
References: <20050106093723.6C35.ODA@valinux.co.jp> <m1y8f7nn75.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050107083247.6C54.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05 Jan 2005 22:25:34 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> One of the problems  Hariprasad and Vivek seem to have been having is
> that the keeping the crash dump kernel from using the first 1M.  You
> have avoided that problem correct?

alloc_pages(ZONE_NORMAL) is used to get memory area for the mini kernel
in "4MB unit"(i386). So the pages is never under 1M.
(for x86_64, alloc_bootmem is used to reserve the memory for the mini
 kernel. alloc_pages does not guarantee under 4GB!!)

> As I recall from looking at your patch and it was obviously your last
> version was that you were using kmalloc or get_free_pages for some 
> of your data structures that controlled the loaded of the mini kernel
> instead of allocating those data structures from the reserved area.

yes. kmalloc is used to get kimage struct. Indeed it is more safe to
put such structues in the reserved area (and write protected).
Thank you for your indication.

> Eric

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

