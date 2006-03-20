Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWCTXdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWCTXdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWCTXdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:33:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964996AbWCTXdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:33:35 -0500
Message-ID: <441F3C2F.2060905@ce.jp.nec.com>
Date: Mon, 20 Mar 2006 18:35:11 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/23] kobject: fix build error if CONFIG_SYSFS=n
References: <11428920371527-git-send-email-gregkh@suse.de>
In-Reply-To: <11428920371527-git-send-email-gregkh@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Moving them inside CONFIG_HOTPLUG && CONFIG_NET will break
CONFIG_NET=n build, because kernel/ksysfs.c will use them
#ifdef CONFIG_HOTPLUG.

Greg Kroah-Hartman wrote:
> Moving uevent_seqnum and uevent_helper to kobject_uevent.c
> because they are used even if CONFIG_SYSFS=n
> while kernel/ksysfs.c is built only if CONFIG_SYSFS=y,
...
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 086a0c6..982226d 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -26,6 +26,8 @@
>  #define NUM_ENVP	32	/* number of env pointers */
>  
>  #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
> +u64 uevent_seqnum;
> +char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
>  static DEFINE_SPINLOCK(sequence_lock);
>  static struct sock *uevent_sock;

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
