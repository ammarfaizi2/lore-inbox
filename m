Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUDOSRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbUDOSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:15:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10244 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263273AbUDOSGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:06:15 -0400
Date: Thu, 15 Apr 2004 14:06:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Smart, James" <James.Smart@Emulex.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: persistence of kernel object attribute ??
In-Reply-To: <3356669BBE90C448AD4645C843E2BF2802C0168A@xbl.ma.emulex.com>
Message-ID: <Pine.LNX.4.53.0404151356290.1515@chaos>
References: <3356669BBE90C448AD4645C843E2BF2802C0168A@xbl.ma.emulex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Smart, James wrote:

>
> I've been looking at everything I can find, asked a few questions, and don't
> have an answer to the following issue.
>
> I have a driver that wants to export attributes per instance. I'd like the
> ability for the user to modify an attribute dynamically (sysfs works well) -
> but I'd like the new value to be persistent the next time the driver
> unloads/loads or the system reboots.  I don't want to have to update
> constants in source and recompile the driver.  I'm looking for something
> similar (cringe!) to the MS registry.  Is there a facility available to
> kernel objects to allow for persistent attributes to be set/retrieved? If
> not, any recommendations on how to implement this ?
>
> -- james
>

Make a program that executes upon startup, using the Sys-V startup
convention. That program interfaces with your driver using a standard
ioctl() call. It can send or receive anything it wants, which it can
get or put to any accessible file-system.

FYI this is the standard Unix/Linux way. You'd be surprised the
large number of users who haven't got a clue about how Unix starts
up. They vaguely remember something about "init" and that's it.
To refresh your memory, look in /etc/rc.d and the sub-directories
for each run-level. Believe me, you don't want or need a "registry".
Just put a link to your startup-script in there.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
            Note 96.31% of all statistics are fiction.


