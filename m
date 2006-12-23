Return-Path: <linux-kernel-owner+w=401wt.eu-S1753872AbWLWXMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbWLWXMb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 18:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbWLWXMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 18:12:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48646 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872AbWLWXMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 18:12:30 -0500
Date: Sat, 23 Dec 2006 15:07:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.19-rc1 build problem
Message-Id: <20061223150715.422c655b.akpm@osdl.org>
In-Reply-To: <458D8E38.4090303@us.ibm.com>
References: <458D8E38.4090303@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2006 14:14:48 -0600
Steve French <smfltc@us.ibm.com> wrote:

> Is this a know problem with very current 2.6.19-rc?
> 
> Building modules, stage 2.
> MODPOST 443 modules
> WARNING: "bitrev32" [drivers/net/8139cp.ko] undefined!

You'll need to set CONFIG_BITREVERSE.  Somehow.  This is going to cause
problems and I suspect we'll end up giving up in horror and just adding it
to lib-y.

> WARNING: "serio_register_driver" [drivers/input/touchscreen/mtouch.ko] 
> undefined!

serio_register_driver is exported, so we're missing a Kconfig dependency
somewhere.

MTOUCH selects SERIO, which seems right, so something weird is happening. 
Please send .config.

