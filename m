Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTISQ4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTISQ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:56:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:10132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261623AbTISQ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:56:30 -0400
Date: Fri, 19 Sep 2003 09:57:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: use O_DIRECT open file, when read will hang.
Message-Id: <20030919095736.284aaa9f.akpm@osdl.org>
In-Reply-To: <200309190939.18796.pbadari@us.ibm.com>
References: <20030919124631.3b4e6301.hugang@soulinfo.com>
	<20030918225450.3d6bb72c.akpm@osdl.org>
	<200309190939.18796.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I am also seeing some kind of regression on raw in 2.6.0-test5-mm2.

What is "some kind of regression"?

> Unfortunately, this happens only with huge database benchmarks.
> I still haven't narrowed it down.

Use mm3 - it has fixes.  Daniel McNeil reports that mm3 fixes the dbt2
problems he was seeing.

> 
> 	- can I do fsx, rawiobench on NFS files to test DIO on NFS ?

Probably, but it will deadlock immediately.

All the i_sem and i_alloc_sem rework needs to be pushed down to the
blockdev_direct_IO level.  That means reverting
O_DIRECT-race-fixes-fixes-2.patch first.


