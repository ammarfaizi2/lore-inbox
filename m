Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUK3Hec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUK3Hec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUK3Hec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:34:32 -0500
Received: from canuck.infradead.org ([205.233.218.70]:25362 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262000AbUK3Hea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:34:30 -0500
Subject: Re: [PATCH] RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is
	broken
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
In-Reply-To: <200411292204.iATM4o4C005049@hera.kernel.org>
References: <200411292204.iATM4o4C005049@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1101800060.2640.21.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 08:34:20 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 21:38 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2251, 2004/11/29 13:38:43-08:00, mtk-lkml@gmx.net
>  
> -	spin_lock(&shmlock_user_lock);
> -	locked = size >> PAGE_SHIFT;
> +	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
>  	lock_limit >>= PAGE_SHIFT;
> +	spin_lock(&shmlock_user_lock);

after this change... isn't the use to the
current->signal->rlim[RLIMIT_MEMLOCK] entirely unlocked and thus racey ?
-- 

