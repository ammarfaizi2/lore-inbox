Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTE1WzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTE1WzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:55:05 -0400
Received: from main.gmane.org ([80.91.224.249]:19918 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261561AbTE1WxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:53:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Raja R Harinath <harinath@cs.umn.edu>
Subject: Re: [CHECKER][PATCH] cmpci user-pointer fix
Date: Wed, 28 May 2003 18:06:32 -0500
Organization: Dept. of Computer Science, Univ. of Minnesota
Message-ID: <d98ysqk6x3.fsf@cs.umn.edu>
References: <5C5CFB74-9149-11D7-8297-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:kQvptPvN12sHqWGhME7y9TpT+HM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hollis Blanchard <hollisb@us.ibm.com> writes:
[snip]
> I believe the attached patch fixes it. cm_write was calling access_ok,
> but after that you must still access user space through the
> get/put/copy*_user functions. It should be safe to return -EFAULT at
> these points in cm_write, since there are other returns already in the
> code above and below that. Compile-tested only.
[snip]
> --- linux-2.5.70/sound/oss/cmpci.c.orig	Sat May 24 19:00:00 2003
> +++ linux-2.5.70/sound/oss/cmpci.c	Wed May 28 14:53:15 2003
> @@ -580,15 +580,17 @@
>  	spin_unlock_irqrestore(&s->lock, flags);
>  }
>  
> -static void trans_ac3(struct cm_state *s, void *dest, const char *source, int size)
> +static int trans_ac3(struct cm_state *s, void *dest, const char *source, int size)

Shouldn't 'source' get the new __user annotation, then:

  const char * __user source

IIRC.

>  {
>  	int   i = size / 2;
> +	int err;
>  	unsigned long data;
>  	unsigned long *dst = (unsigned long *) dest;
>  	unsigned short *src = (unsigned short *)source;

Likewise with 'src'.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu

