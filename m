Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGOX3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGOX3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGOX3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:29:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbVGOX1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:27:52 -0400
Date: Fri, 15 Jul 2005 16:23:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050715162349.731ca00d.akpm@osdl.org>
In-Reply-To: <20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
>
> Hi Andrew
> 
> I got the following error.
> 
> make ARCH=mips oldconfig
> scripts/kconfig/conf -o arch/mips/Kconfig
> drivers/video/Kconfig:7:warning: type of 'FB' redefined from 'boolean' to 'tristate'
> 
> file drivers/char/speakup/Kconfig already scanned?
> make[1]: *** [oldconfig] Error 1
> make: *** [oldconfig] Error 2
> 

Well arch/mips/Kconfig is defining CONFIG_FB as bool and
drivers/video/Kconfig was changed a while ago to define it as tristate.  I
assume this failure also happens in linus's current tree.  

It seems odd that mips is privately duplicating the generic code's
definition.  Maybe that needs to be taken out of there.

I'll cc the fbdev guys - could someone please come up with fix?  It's a
showstopper for the MIPS architecture.
