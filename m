Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVBBHmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVBBHmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBBHmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:42:35 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:30670 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261976AbVBBHm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:42:26 -0500
Date: Wed, 02 Feb 2005 16:42:28 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
References: <41FF381B.4080904@intellilink.co.jp> <m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050202161108.18D7.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't like calling crash_kexec() directly in (ex.) panic().
It should be call_dump_hook() (or something like this).

I think the necessary modifications of the kernel is only:
- insert the hooks that calls a dump function when crash occur
- binding interface that binds a dump function to the hook
  (like register_dump_hook())
- supply the information of valid physical address regions
(- maybe some existent functions and variables need to be exported ?)

I think this makes any sort of dump functions can be implemented
as a kernel module. I don't think it is best way that the "kexec based 
crashdump" is built in the kernel.

Thanks.

On 01 Feb 2005 02:06:42 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Koichi Suzuki <koichi@intellilink.co.jp> writes:
> 
> > Hook in panic code is very good idea and is useful in various scenes. It could
> > be used to kick RAM dump code, obviously, and also kick the code to initiate
> > failover, etc.   Various use could be possible so I believe that this hook
> > should be prepared for wider use.
> 
> It is.  Basically it is the normal kexec interface that allows you to
> boot another kernel.  With a few restrictions that should keep it as
> reliable as possible when the kernel has not shut itself down cleanly.
> 
> The hardest case is to do a useful system core dump.  As that requires
> looking at what has gone before.  For the rest if you can do it
> with a kernel and a initramfs you are in good shape.
> 
> There seems to be a significant amount of interest in the full
> system core dump case so that is what the work is concentrating
> on.
> 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Itsuro ODA <oda@valinux.co.jp>

