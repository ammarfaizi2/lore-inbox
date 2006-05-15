Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWEOVKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWEOVKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWEOVKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:10:48 -0400
Received: from mx.pathscale.com ([64.160.42.68]:39300 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965223AbWEOVKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:10:47 -0400
Subject: Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for
	writes
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       Ralphc@pathscale.com
In-Reply-To: <adazmhjth56.fsf@cisco.com>
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
	 <adazmhjth56.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:10:47 -0700
Message-Id: <1147727447.2773.14.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 08:57 -0700, Roland Dreier wrote:
>  >  static void i2c_wait_for_writes(struct ipath_devdata *dd)
>  >  {
>  > +	mb();
>  >  	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
>  >  }
> 
> This needs a comment explaining why it's needed.  A memory barrier
> before a readl() looks very strange since readl() should be ordered anyway.

Yeah.  It's actually working around what appears to be a gcc bug if the
kernel is compiled with -Os.  Ralph knows the details; he can give a
more complete answer.

	<b

