Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVAUPnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVAUPnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVAUPnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:43:39 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:46118 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262391AbVAUPnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:43:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XCk8POKpjuw4P3PYy9agO67Mg1GBDXWglyrYOfHts7rayEmvEu+GCO6wdqdC/TCGVEN1+i4m37w17QO0tC5lZNXTxhzuCn/ouKQXNUUnNVgXUmH0HKogg+J/8R62OMdxjlb5JXCRwoTd8pSvn6dytgv1cJYaunxHhlP1AGouqOU=
Message-ID: <d120d500050121074313788f99@mail.gmail.com>
Date: Fri, 21 Jan 2005 10:43:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Prarit Bhargava <prarit@sgi.com>
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
In-Reply-To: <41F11C66.5000707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F11C66.5000707@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jan 2005 10:14:46 -0500, Prarit Bhargava <prarit@sgi.com> wrote:
> Hi,
> 
> The following patch cleans up resource allocations in the i8042 driver
> when initialization fails.
> 
...
> 
>                if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
> -                       printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> +                       if (i8042_read_status() != 0xFF)
> +                               printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
> +                       else
> +                               printk(KERN_ERR "i8042.c: no i8042 controller found.\n");

Is this documented somewhere?

> 
>        if (i8042_platform_init())
> +       {
> +               del_timer_sync(&i8042_timer);
>                return -EBUSY;
> +       }
> 

Couple of comments:
 - i8042_timer has not been started yet so there is no need to delete
it in either of the chinks.
- opening brace placement does not follow Linux coding style.

I think I have some changes to i8042 in my tree, I will add
i8042_platform_exit calls to the init routine. Thanks for noticing it!

-- 
Dmitry
