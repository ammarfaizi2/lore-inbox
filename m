Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUAGUbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAGUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:31:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14095 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266320AbUAGUbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:31:07 -0500
Date: Wed, 7 Jan 2004 21:43:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel buildsystem broken on RO medium
Message-ID: <20040107204345.GA2812@mars.ravnborg.org>
Mail-Followup-To: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
	linux-kernel@vger.kernel.org
References: <200401070041.41598.arekm@pld-linux.org> <20040107061628.GA2165@mars.ravnborg.org> <200401070951.27249.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401070951.27249.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow now works but tell me, how to do make mrproper if /usr/src/linux-2.6.1 is really read-only?
> I'm asking because I want to build rpms with kernel modules from non-root and root can have
> non-mrproper state in /usr/src/linux-2.6.1.

There is no way to do this, other than take a copy of the SRC.
It was not possible to let kbuild support building a kernel when the kernel
tree contained generated files.
I do not remember the details, but the main issue was with generated .c
files. If a generated .c file were present in the kernel src, it would
not be generated aging in the separate output directory.
Usually this is not too much of a big deal, but it could result in potential
erros later on.
There were also problems with _shipped support and generated .h files,
but I do not recall the details.

In the 2.7 timeframe I plan to be a bit more restrictive on use of -I
directive to gcc, hereby hopefully enabling more consistent behaviour
all over the kernel.

	Sam
