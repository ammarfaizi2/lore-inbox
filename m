Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTFBJzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTFBJzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:55:06 -0400
Received: from pointblue.com.pl ([62.89.73.6]:32774 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262123AbTFBJy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:54:59 -0400
Date: Mon, 2 Jun 2003 12:08:25 +0200 (CEST)
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Chris Wright <chris@wirex.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>, <greg@kroah.com>,
       <sds@epoch.ncsc.mil>
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
In-Reply-To: <20030602025450.C27233@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Chris Wright wrote:

> @@ -91,7 +92,7 @@
>  	 * Superuser processes are usually more important, so we make it
>  	 * less likely that we kill those.
>  	 */
> -	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
> +	if (!security_capable(p,CAP_SYS_ADMIN) ||
>  				p->uid == 0 || p->euid == 0)
>  		points /= 4;
..............
> -	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
> +	if (!security_capable(p,CAP_SYS_RAWIO))
>  		points /= 4;

Correct me if i am wrong, but I think it is not a good idea to favor 
applications with more 
capabilities, as ussualy those are most wanted target on a system.


--
Grzegorz Jaskiewcz

