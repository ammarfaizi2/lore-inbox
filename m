Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWIOQ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIOQ55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIOQ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:57:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:53142 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750821AbWIOQ5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:57:55 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060914165205.c56365e7.akpm@osdl.org>
References: <1158083865.18137.13.camel@localhost.localdomain>
	 <20060914165205.c56365e7.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 09:57:49 -0700
Message-Id: <1158339469.16727.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 16:52 -0700, Andrew Morton wrote:
> On Tue, 12 Sep 2006 10:57:45 -0700
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> 
> > SLIM is an LSM module which provides an enhanced low water-mark
> > integrity and high water-mark secrecy mandatory access control
> > model.
> > 
> 
> trivial things:
> 
> 
> > --- linux-2.6.18/security/slim/slm_main.c	1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.17-working/security/slim/slm_main.c	2006-09-06 11:49:09.000000000 -0700
> > @@ -0,0 +1,1378 @@
> > +/*
> > + * SLIM - Simple Linux Integrity Module
> > + *
> > + * Copyright (C) 2005,2006 IBM Corporation
> > + * Author: Mimi Zohar <zohar@us.ibm.com>
> > + * 	   Kylene Hall <kjhall@us.ibm.com>
> > + *
> > + *      This program is free software; you can redistribute it and/or modify
> > + *      it under the terms of the GNU General Public License as published by
> > + *      the Free Software Foundation, version 2 of the License.
> > + */
> > +
> > +#include <linux/mman.h>
> > +#include <linux/config.h>
> > +#include <linux/kernel.h>
> > +#include <linux/security.h>
> > +#include <linux/integrity.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/socket.h>
> > +#include <linux/fs.h>
> > +#include <linux/file.h>
> > +#include <linux/namei.h>
> > +#include <linux/mm.h>
> > +#include <linux/shm.h>
> > +#include <linux/ipc.h>
> > +#include <linux/errno.h>
> > +#include <linux/xattr.h>
> > +#include <net/sock.h>
> > +
> > +#include "slim.h"
> > +
> > +#define XATTR_NAME "security.slim.level"
> > +
> > +#define ZERO_STR "0"
> > +#define UNTRUSTED_STR "UNTRUSTED"
> > +#define USER_STR "USER"
> > +#define SYSTEM_STR "SYSTEM"
> > +
> > +char *slm_iac_str[] = {
> > +	ZERO_STR,
> > +	UNTRUSTED_STR,
> > +	USER_STR,
> > +	SYSTEM_STR
> > +};
> 
> Could this be made static?
I don't think so because it is used in slm_secfs.c

I'll get the rest fixed up and submit a patch.

Thanks,
Kylie

