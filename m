Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965387AbWAGA2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965387AbWAGA2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWAGA1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:27:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965387AbWAGA12 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:27:28 -0500
Date: Fri, 6 Jan 2006 16:29:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] Series to allow a "const" file_operations struct
Message-Id: <20060106162913.7621895c.akpm@osdl.org>
In-Reply-To: <43BEF338.3010403@cosmosbay.com>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
	<1136584539.2940.105.camel@laptopd505.fenrus.org>
	<43BEF338.3010403@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Arjan van de Ven a écrit :
> > On Fri, 2006-01-06 at 22:45 +0100, Arjan van de Ven wrote:
> >> Hi,
> >>
> >> this series allows drivers to have "const" file_operations, by making
> >> the f_ops field in the inode const. This has another benefit, there have
> > 
> > ok there was a sentence missing here. The first benefit is that this
> > moves these hot datastructures to the rodata section, which means they
> > won't accidentally be doing false cacheline sharing.
> > 
> 
> Definitly a good thing I agree.
> 
> But your patches miss to really declare all 'struct file_operations' as const, 
> dont they ?
> 
> 
> On my x86_64 machine, I managed to reduce by 10% .data section by moving all 
> file_operations, but also 'address_space_operations', 'inode_operations, 
> super_operations, dentry_operations, seq_operations, ... to rodata section.
> 
> size vmlinux*
>     text    data     bss     dec     hex filename
> 2476156  522236  244868 3243260  317cfc vmlinux
> 2588685  571348  246692 3406725  33fb85 vmlinux.old
> 

Confused.   Why should this result in an aggregate reduction in vmlinux size?
