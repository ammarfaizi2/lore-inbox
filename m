Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUJWUWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUJWUWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJWUWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:22:14 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46060 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261173AbUJWUUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:20:40 -0400
Date: Sat, 23 Oct 2004 22:20:37 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Driver Core patches for 2.6.9
Message-ID: <20041023202037.GA12345@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10982037783139@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> ha scritto:
> ChangeSet 1.1867.3.4, 2004/09/15 11:36:09-07:00, greg@kroah.com
> 
> kevent: standardize on the event types
> 
> This prevents any potential typos from happening.

[cut]

> diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> --- a/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> +++ b/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> @@ -19,9 +19,29 @@
> #include <linux/skbuff.h>
> #include <linux/netlink.h>
> #include <linux/string.h>
> +#include <linux/kobject_uevent.h>
> #include <linux/kobject.h>
> #include <net/sock.h>
> 
> +/* 
> + * These must match up with the values for enum kobject_action
> + * as found in include/linux/kobject_uevent.h
> + */
> +static char *actions[] = {
> +       "add",          /* 0x00 */
> +       "remove",       /* 0x01 */
> +       "change",       /* 0x02 */
> +       "mount",        /* 0x03 */
> +};

Hi Greg,
maybe it's just a matter of taste but I think that is better to do
something like this:

static char *actions[] = {
        [KOBJ_ADD]      = "add",
        [KOBJ_REMOVE]   = "remove",
        [KOBJ_CHANGE]   = "change",
        [KOBJ_MOUNT]    = "mount",
};

This would prevent the insertion of a new action in the wrong place.

Luca
-- 
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}
