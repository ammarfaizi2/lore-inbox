Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRGADSr>; Sat, 30 Jun 2001 23:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbRGADS1>; Sat, 30 Jun 2001 23:18:27 -0400
Received: from [130.130.68.25] ([130.130.68.25]:25845 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264957AbRGADSZ>; Sat, 30 Jun 2001 23:18:25 -0400
Message-ID: <3B3E95F5.5AFCF5DD@uow.edu.au>
Date: Sun, 01 Jul 2001 13:16:05 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Schmidklofer <menion@fmtc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 - IpConfig, BOOTP not functioning.
In-Reply-To: <3B3D0B4A.9040603@fmtc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Schmidklofer wrote:
> 
> Kernel developers,
>    I hate to burden you with menial quetions, but:   How does ipconfig
> get called & initialized?

The magic happens right at the end of ipconfig.c:

__setup("ip=", ip_auto_config_setup);
__setup("nfsaddrs=", nfsaddrs_config_setup);

When the kernel boots it runs init/main.c:parse_options() to parse
the kernel boot command line.  The function init/main.c:checksetup()
will call ip_auto_config_setup() when it sees an argument of the
form "ip=XXXX" on the command line.

If there is no `ip=' argument then ip_auto_config_setup() will
not be called at all.

-
