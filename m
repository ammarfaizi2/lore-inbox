Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbSI3Ojp>; Mon, 30 Sep 2002 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262111AbSI3Ojp>; Mon, 30 Sep 2002 10:39:45 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:53245 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262074AbSI3Ojo>; Mon, 30 Sep 2002 10:39:44 -0400
Subject: Re: [RFC] LSM changes for 2.5.38
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
In-Reply-To: <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
References: <20020927003210.A2476@sgi.com>
	<Pine.GSO.4.33.0209270743170.22771-100000@raven>
	<20020927175510.B32207@infradead.org>
	<200209271809.g8RI92e6002126@turing-police.cc.vt.edu>
	<20020927191943.A2204@infradead.org>
	<200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>
	<20020927195919.A4635@infradead.org> 
	<200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 15:51:11 +0100
Message-Id: <1033397471.16947.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 15:19, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 27 Sep 2002 19:59:19 BST, Christoph Hellwig said:
> 
> > insmod doesn't require modules to be in /lib/modules.
> 
> This would probably be closed by this code in sys_create_module():
> 
>         /* check that we have permission to do this */
>         error = security_ops->module_ops->create_module(name, size);
>         if (error)
>                 goto err1;

This is part of the problem as ever. The name that is used is
meaningless. The module loader needs to make meaningful decisions. That
really means it needs to be able to see the actual loaded module. If we
go to Rusty's kernel module loader then we can fix this because we can
pass the actual module code/data block and sizes to the LSM. At that
point the LSM can do meaningful things like GPG.

In the current form you can say that module creation can only be done by
the right kind of user, and the program "insmod", but even in this case
the module name fed to the LSM seems worthless


