Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUINV6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUINV6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUINVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:50:38 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:27153 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269653AbUINVnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:43:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Kernel stack overflow on 2.6.9-rc2
Date: Wed, 15 Sep 2004 00:42:57 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       netdev@oss.sgi.com
References: <200409141723.35009.vda@port.imtp.ilyichevsk.odessa.ua> <20040914163347.GE3197@schnapps.adilger.int>
In-Reply-To: <20040914163347.GE3197@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409150042.57208.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 September 2004 19:33, Andreas Dilger wrote:
> On Sep 14, 2004  17:23 +0300, Denis Vlasenko wrote:
> > I am putting to use an ancient box. Pentium 66.
> > It gives me stack overflow errors on 2.6.9-rc2:
> >
> > To save you filtering out functions with less than 100
> > bytes of stack:
> >
> > udp_sendmsg+0x35e/0x61a [220]
> > sock_sendmsg+0x88/0xa3 [208]
> > __nfs_revalidate_inode+0xc7/0x308 [152]
> > nfs_lookup_revalidate+0x257/0x4ed [312]
> > load_elf_binary+0xc4f/0xcc8 [268]
> > load_script+0x1ea/0x220 [136]
> > do_execve+0x153/0x1b9 [336]
>
> do_execve() can be trivially fixed to allocate bprm (328 bytes) instead
> putting it on the stack.  Given the frequency of exec and the odd size
> it should probably be in its own slab (and fix the goofy prototype
> indenting while you're there too ;-).
>
> load_elf_binary() on the other hand is a big mess, 132 bytes of int/long
> variables.

268 bytes according to checkstack.
--
vda

