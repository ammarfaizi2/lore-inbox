Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVBNQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVBNQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVBNQu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:50:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261482AbVBNQuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:50:18 -0500
Date: Mon, 14 Feb 2005 11:50:01 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] 5/5: LSM hooks rework
In-Reply-To: <20050213211238.GM27893@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0502141143420.24807-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005, Kurt Garloff wrote:

>  /* Condition for invocation of non-default security_op */
>  #define COND_SECURITY(seop, def) 	\
> -	(likely(security_ops == &capability_security_ops))? def: security_ops->seop
> +	(unlikely(security_enabled))? security_ops->seop: def

So this will cause a false unlikely() for every single SELinux hook,
again.  This was rejected last year.  The thread you pointed to has some
discussion of dealing with the problematic ia64 case, although there's no
evidence in these patches that anything has progressed in that area since
then.


- James
-- 
James Morris
<jmorris@redhat.com>



