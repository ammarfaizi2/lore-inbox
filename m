Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbTDFNYL (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTDFNYL (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:24:11 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:6787 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S262959AbTDFNYK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:24:10 -0400
Message-Id: <200304061335.h36DZfY06199@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: robn@verdi.et.tudelft.nl, linux-kernel@vger.kernel.org
Subject: Re: Serial port over TCP/IP 
In-Reply-To: Your message of "Sun, 06 Apr 2003 14:47:46 +0200."
             <200304061447.46393.freesoftwaredeveloper@web.de> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Sun, 06 Apr 2003 15:35:41 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Buesch wrote:
> Is it possible to make a char-dev (a serial device ttyS0)
> available via TCP/IP on a network like it is possible
> for block-devices like a harddisk via nbd?
> Is kernel-support for this present?
> If not, is it technically possible to develop such a driver?

Hi Michael,

No need for kernel support.  This simple shell-script is what I use for
a project at the moment.

	greetings,
	Rob van Nieuwkerk

------------------------------------------------
#!/bin/sh

TCP_PORT=4000
SERIAL_PORT=/dev/ttyS1
BAUDRATE=19200

while (true)
	do
	(stty $BAUDRATE -echo clocal raw pass8 ; exec nc -l -p $TCP_PORT) \
		< $SERIAL_PORT > $SERIAL_PORT
done
------------------------------------------------
