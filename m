Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVFUTgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVFUTgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVFUTgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:36:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262254AbVFUTgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:36:52 -0400
Date: Tue, 21 Jun 2005 12:35:07 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rostedt@goodmis.org, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: [RFC: 2.6 patch] better USB_MON dependencies
Message-Id: <20050621123507.6b83ddf0.zaitcev@redhat.com>
In-Reply-To: <20050621143227.GO3666@stusta.de>
References: <Pine.LNX.4.58.0506172156220.7916@ppc970.osdl.org>
	<1119119175.6786.4.camel@localhost.localdomain>
	<20050621143227.GO3666@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 16:32:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:

> The patch below tries to solve this in a better way.

>  config USB_MON
> -	tristate "USB Monitor"
> -	depends on USB
> +	bool "USB Monitor"
> +	depends on USB!=n
>  	default y

This is a good idea and I wanted to do it for a while, only I was unable
to figure how to write the "depends on USB!=n" part. I'm all for it.
Let me give it a test here just to be sure, but I think we're good.

One question though, do we want this:

> -obj-$(CONFIG_USB_MON)		+= mon/
> +ifdef CONFIG_USB_MON
> +  obj-$(CONFIG_USB)		+= mon/
> +endif

Seems superfluous to me, because we kept CONFIG_USB_MON. This place should
probably be left alone.

-- Pete
