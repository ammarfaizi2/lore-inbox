Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWDGTOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWDGTOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWDGTOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:14:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27147 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932431AbWDGTOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:14:18 -0400
Date: Fri, 7 Apr 2006 21:13:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Message-ID: <20060407191359.GC9097@mars.ravnborg.org>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:36:00PM -0500, Serge E. Hallyn wrote:
> This patch defines the uts namespace and some manipulators.
> Adds the uts namespace to task_struct, and initializes a
> system-wide init namespace which will continue to be used when
> it makes sense.
It also kills system_utsname so you left the kernel uncompileable.
Can you kill it later?

> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 13e1da0..cc28ac5 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -1,5 +1,8 @@
>  #ifndef _LINUX_UTSNAME_H
>  #define _LINUX_UTSNAME_H
You can kill this include
> +#include <linux/sched.h>

if you move this static inline to sched.h
 +
> +static inline struct new_utsname *utsname(void)
> +{
> +	return &current->uts_ns->name;
> +}
And since it operates on &current that may make sense.

	Sam
