Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTICXzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTICXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:55:36 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:64195 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264312AbTICXzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:55:35 -0400
Message-ID: <3F5680AF.8030405@pacbell.net>
Date: Wed, 03 Sep 2003 17:00:47 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB modem no longer detected in -test4
References: <20030903191701.GA2798@elf.ucw.cz>
In-Reply-To: <20030903191701.GA2798@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> In 2.6.0-test4, USB ELSA modem no longer works. This is UHCI (on
> toshiba 4030cdt).
> 
> Relevant messages seem to be:
> 
> PM: Adding info for usb:1-1.2
> drivers/usb/class/cdc-acm.c: need inactive config#2
> PM: Adding info for usb:1-1.2:0
> drivers/usb/class/cdc-acm.c: need inactive config#2


Try the usb_set_configuration() patch I just posted this morning
(to linux-usb-devel).

Apply it, and you'll still get these messages ... but then you'll
be able to

    # echo 2 > /sys/bus/usb/devices/1-1.2/bConfigurationValue

and then it should work as before.  Granted that works as I expect,
I'll submit a cdc-acm patch later to get rid of the need for the
manual workaround.  And meanwhile, a hotplug script could automate
this for you, in /etc/hotplug/usb/cdc-acm ...

- Dave



