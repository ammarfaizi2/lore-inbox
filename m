Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUADVst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUADVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:48:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:8845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264392AbUADVsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:48:47 -0500
Date: Sun, 4 Jan 2004 13:48:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org, kpfleming@cox.net
Subject: Re: [PATCH]: Fw: [Bugme-new] [Bug 1242] New: devfs oops with SMP
 kernel (not in UP mode)
Message-Id: <20040104134844.1aa69452.akpm@osdl.org>
In-Reply-To: <200401041932.40960.arvidjaar@mail.ru>
References: <20030915212755.5017acc7.akpm@osdl.org>
	<200401041932.40960.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> On Tuesday 16 September 2003 08:27, Andrew Morton wrote:
>  > Andrey,
>  >
>  > didn't we fix this?
>  >
>  >
> 
>  Sorry for delay. Oops is due to concurrent d_instantiate on the same dentry; 
>  the bug was unfortunately quite ugly to fix inside devfs itself.

Andrey, thanks for working on this.  It is good to have a go-to guy for
devfs problems.  They all seem to be nasty nowadays.

>  The attached patch makes sure d_revalidate is always called under parent i_sem 
>  allowing it to drop and reacquire semaphore before going to wait. It provides 
>  both mutual exclusion with devfs_lookup and between d_revalidate, fixing

Alas, people will have a heart-attack over the fs/namei.c changes.  Is it
not possible to add an additional semaphore into devfs to provide this
exclusion?  Are there any alternatives you can think of?



