Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVLBB7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVLBB7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVLBB7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:59:42 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:41838 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964777AbVLBB7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:59:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jurriaan <thunder7@xs4all.nl>
Subject: Re: mouse resync messages since 2.6.15-rc2-mm1, still in 2.6.15-rc3-mm1
Date: Thu, 1 Dec 2005 20:59:38 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051201195145.GA20896@amd64.of.nowhere>
In-Reply-To: <20051201195145.GA20896@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512012059.39163.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 14:51, jurriaan wrote:
> I access my workstations with a KVM switch, a Rose Vista model, and
> since 2.6.15-rc2-mm1, I get an awful lot of
> 
> logips2pp: Detected unknown logitech mouse model 1
> psmouse.c: resync failed, issuing reconnect request
> 
> messages. What is the information content in these messages? I take it
> they tell me something important - but I can't understand what. If they
> are just noise, could they please be removed?
> I know my mouse works when I switch consoles; this KVM has worked for
> ages with linux. 
>

You not supposed to see thiese messages. When you boot, what mouse type
does the kernel detect? Could you send me your dmesg please? Also, if
you could do:

1. echo 1 > /sys/modules/i8042/parameters/debug
2. Switch your KVM to another box
3. Wait 5 seconds
4. Switch back
5. Move the mouse slightly
6. echo 0 > /sys/modules/i8042/parameters/debug

... and send me dmesg I would appreciate it. 

> I can always #if 0 them out myself, but I'm curious what the meaning of
> these messages is.
>

You can disable resync mode by doing:

	echo -n 0 > /sys/bus/serio/devices/serioX/resync_time

where serioX is serio port your mouse is connected to.

-- 
Dmitry
