Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbSJNQqH>; Mon, 14 Oct 2002 12:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJNQqH>; Mon, 14 Oct 2002 12:46:07 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:45034 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S262036AbSJNQqF>; Mon, 14 Oct 2002 12:46:05 -0400
Date: Mon, 14 Oct 2002 09:53:19 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42,
 2.5.41 boot hang with CONFIG_USB_DEBUG=n
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <3DAAF67F.1080504@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021013172557.GA890@rousalka.noos.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now it turns out I didn't do such a piss-poor of configuring my 2.5 
> kernel, since the only option I could find that make a difference was 
> CONFIG_USB_DEBUG. When I accept flooding my system logs with obscure usb 
> incantations the system boots:(.   ...
> 
>     Can an helpful soul help me bring my system some relief  ? I'd 
> really like not to boot in debug mode.

That's a new failure mode!   Can you help narrow this down?

You're using the OHCI driver, so you can just tweak the lines at the
top of drivers/usb/host/ohci-hcd.c that can #define DEBUG.  If you
comment out that #define, and leave CONFIG_USB_DEBUG on (and then
rebuild and re-init with the new OHCI driver), does that work or not?

If that works, it'd be time to see which OHCI printk()s morph init (?)
timing enough to matter to your K7 box.   Looked to me like they were
all either before or after the timing-critical bits (chip init), so
disabling just the OHCI messages "should" not change your failure mode.

- Dave



