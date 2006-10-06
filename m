Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWJFXDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWJFXDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJFXDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:03:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422732AbWJFXDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:03:35 -0400
Date: Fri, 6 Oct 2006 16:03:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/9] sound/oss/msnd_pinnacle.c: ioremap balanced with
 iounmap
Message-Id: <20061006160324.142ccebf.akpm@osdl.org>
In-Reply-To: <1160113137.19143.140.camel@amol.verismonetworks.com>
References: <1160113137.19143.140.camel@amol.verismonetworks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006 11:08:57 +0530
Amol Lad <amol@verismonetworks.com> wrote:

>  msnd_pinnacle.c |   10 ++++++++++

This driver fails to check that ioremap() actually succeeded.  Hence with
this patch we can end up doing iounmap(NULL).

Now it _could_ be that the kernel permits iounmap(NULL).  But I don't
recall that being the rule, and from my reading the powerpc 64-bit iounmap
(at least) will go splat if we do this to it.  Most other implementations
will permit iounmap(NULL) by accident.  
