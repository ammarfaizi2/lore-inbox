Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVAXVno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVAXVno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAXVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:42:26 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:55355 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261606AbVAXVle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:41:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=T1UqHg7CIHCquKRkekcY5vqhmJddPlik/T7idaWIBsVV4FxxAqC6CotfRiMQrp85YyU/N0go1flw4OmEsoOdlQpKap/xhJgmP/kQjfkAopztmJ2/jv68jpgZ8dJLNzkbB/+rPmXqD8ChhJyiPEPA1yjyrg0eBxNouBSFneCjAgU=
Message-ID: <29495f1d05012413415c66974b@mail.gmail.com>
Date: Mon, 24 Jan 2005 13:41:33 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] superio: change scx200 module name to scx.
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050124233720.484c7ad0@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124233720.484c7ad0@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 23:37:20 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> Change scx200 module name to scx.
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> 
> --- linux-2.6/drivers/superio/scx.c     1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/drivers/superio/scx.c     2005-01-24 22:06:15.000000000 +0300

<snip>

> +static void scx200_fini(void)
> +{
> +       sc_del_sc_dev(&scx200_dev);
> +
> +       while (atomic_read(&scx200_dev.refcnt))
> +       {
> +               printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
> +                               scx200_dev.name, atomic_read(&scx200_dev.refcnt));
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               schedule_timeout(HZ);
> +
> +               if (current->flags & PF_FREEZE)
> +                       refrigerator(PF_FREEZE);
> +
> +               if (signal_pending(current))
> +                       flush_signals(current);
> +       }

<snip>

I believe this schedule_timeout() call can be an msleep_interruptible(1000).

Thanks,
Nish
