Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVAaPDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVAaPDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVAaPDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:03:44 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:38457 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVAaPDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:03:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=B0VKQWYqPZYRm/sl451ptpDYVSceiZMhkibahDfaW6QYc6ZjDrLycqhAa5D+IQpwbaR81rLcP7jbBcXJLD2Dqg5qCX2JoWaxDqP4xVuya42X9dnAcEb1Uyt9WlQdrCmmhv29ZhnvLjzJe1vx7MXgqNqRsWiWIaPzSssX0kgPVd0=
Message-ID: <d120d50005013107005a8c39b1@mail.gmail.com>
Date: Mon, 31 Jan 2005 10:00:51 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] connector.c: make notify_lock static
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050131124119.GE18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131124119.GE18316@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 13:41:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> notify_lock isn't a good name for a global lock.
> But since it's not used outside of the file, it can be made static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c.old 2005-01-31 13:09:14.000000000 +0100
> +++ linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c     2005-01-31 13:09:28.000000000 +0100
> @@ -41,7 +41,7 @@
> module_param(cn_idx, uint, 0);
> module_param(cn_val, uint, 0);
> 
> -spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
> +static spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
> static LIST_HEAD(notify_list);
> 
> static struct cn_dev cdev;
> 

Isn't this supposed to be "static DEFINE_SPINLOCK(notify_lock);" nowadays?

-- 
Dmitry
