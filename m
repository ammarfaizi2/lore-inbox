Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbTAJGq6>; Fri, 10 Jan 2003 01:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268127AbTAJGq6>; Fri, 10 Jan 2003 01:46:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:49910 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263256AbTAJGq5>;
	Fri, 10 Jan 2003 01:46:57 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.28265.876060.314756@harpo.it.uu.se>
Date: Fri, 10 Jan 2003 07:55:37 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't build sound drivers as modules (2.5.55)
In-Reply-To: <1042147153.4870.66.camel@dell_ss3.pdx.osdl.net>
References: <1042147153.4870.66.camel@dell_ss3.pdx.osdl.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger writes:
 > When I try to install with sound as a configured module:
 > 
 > WARNING: /lib/modules/2.5.55/kernel/sound/soundcore.ko needs unknown
 > symbol
 >  errno
 > 
 > This is new in 2.5.55, not sure where the missing bogus definition is.
 > It looks like soundcore.ko contains sound_firmware.o which is seems to
 > be more of an application than a driver (open/close)...

Someone removed the 'static int errno;' declaration in sound_firmware.c.
The sys calls it uses are apparently user-space versions with errno references.

The real fix is to delete the file altogether :-) Like the comments in it
say, firmware should be inserted by a user-space application.
