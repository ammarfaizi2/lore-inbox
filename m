Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUGPF7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUGPF7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUGPF7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:59:05 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:1135 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266240AbUGPF7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:59:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse as module with suspend/resume
Date: Fri, 16 Jul 2004 00:58:57 -0500
User-Agent: KMail/1.6.2
Cc: Kevin Fenzi <kevin-kernel@scrye.com>
References: <20040715205459.197177253D@voldemort.scrye.com>
In-Reply-To: <20040715205459.197177253D@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407160058.57824.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 July 2004 03:54 pm, Kevin Fenzi wrote:
> 
> Greetings.
> 
> I am having a bit of an issue with psmouse and suspend/resume.
> I am using the swsusp2, which is working great... (Thanks Nigel!)
> 
> However:
> 
> If I compile psmouse as a module and leave it in and suspend/resume
> when the laptop comes back the mouse doesn't work at all.
> 
> If I compile psmouse as a module and unload before suspend, and reload
> after resume, the mouse works for simple movement, but all the
> advanced synaptics features no longer work. No tap for mouse button,
> no scolling, etc.
> 
> If I compile psmouse in everything works after a suspend/resume cycle.
>

There should not be any differences between module and compiled version.
Could you please change #undef DEBUG to #define DEBUG in
drivers/input/serio/i8042.c module and post the full dmesg (you may have
to use log_buf_size=131072 and 'dmesg -s 131072' to get the full dmesg).
 
> I would like to be able to compile psmouse as a module. Does anyone
> see any reason the synaptics stuff wouldn't work after a
> unload/reload?

When you reload do you do it from X or from text console? Do you have GPM
running? If some program has the device open when you reload a new device
will be created. X closes the device when switching to a text console, so
just kill GPM before reloading psmouse and it should help.

-- 
Dmitry
