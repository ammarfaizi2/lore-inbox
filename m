Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWEZSI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWEZSI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWEZSI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:08:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751228AbWEZSI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:08:57 -0400
Date: Fri, 26 May 2006 11:08:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2]Define ext3 in-kernel filesystem block types and
 extend ext3 filesystem limit from 8TB to 16TB
Message-Id: <20060526110803.50380d55.akpm@osdl.org>
In-Reply-To: <1148619653.5855.16.camel@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	<1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	<20060327131049.2c6a5413.akpm@osdl.org>
	<20060327225847.GC3756@localhost.localdomain>
	<1143530126.11560.6.camel@openx2.frec.bull.fr>
	<1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	<1143623605.5046.11.camel@openx2.frec.bull.fr>
	<1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	<1148619653.5855.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Some of the in-kernel ext3 block variable type are treated as signed 4 bytes
>  int type, thus limited ext3 filesystem to 8TB (4kblock size based). While
>  trying to fix them, it seems quite confusing in the ext3 code where some
>  blocks are filesystem-wide blocks, some are group relative offsets that need
>  to be signed value (as -1 has special meaning). So it seem saner to define two
>  types of physical blocks: one is filesystem wide blocks, another is
>  group-relative blocks.  The following patches clarify these two types of
>  blocks in the ext3 code, and fix the type bugs which limit current 32 bit ext3
>  filesystem limit to 8TB.
> 
>  With this series of patches and the percpu counter data type changes in the mm
>  tree, we are able to extend exts filesystem limit to 16TB.

Did you look at the `gcc -W' output before and after these patches are
applied?  That would have found the bug which the previous version
of these patches introduced.

We already get a pile of `warning: comparison between signed and unsigned'
warnings which should be checked, too..

