Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWA3WEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWA3WEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWA3WEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:04:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41195 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932345AbWA3WEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:04:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [ 06/23] [Suspend2] Disable usermode helper invocations when the freezer is on.
Date: Mon, 30 Jan 2006 23:05:17 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034539.3178.56611.stgit@localhost.localdomain>
In-Reply-To: <20060126034539.3178.56611.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302305.18202.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 26 January 2006 04:45, Nigel Cunningham wrote:
> 
> Disable usermode helper invocations when the freezer is on. This avoids
> deadlocks due to hotplug events occuring while processes are frozen.
> 
> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
>  kernel/kmod.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index 51a8920..12afa2c 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -36,6 +36,7 @@
>  #include <linux/mount.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/freezer.h>
>  #include <asm/uaccess.h>
>  
>  extern int max_threads;
> @@ -249,6 +250,9 @@ int call_usermodehelper_keys(char *path,
>  	if (!khelper_wq)
>  		return -EBUSY;
>  
> +	if (freezer_is_on())
> +		return 0;
> +
>  	if (path[0] == '\0')
>  		return 0;
>  

Disabling the usermode helper while freeze_processes() is executed seems to be
a good idea to me, but I think it should be done with a mutex or something
like that.

Greetings,
Rafael
