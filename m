Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbULKUXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbULKUXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULKUXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:23:19 -0500
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:18660 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S262008AbULKUXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:23:16 -0500
Date: Sat, 11 Dec 2004 15:23:14 -0500
From: Jim Paris <jim@jtan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI IRQ problems -- update
Message-ID: <20041211202314.GA22731@jim.sh>
References: <20041211173538.GA21216@jim.sh> <1102783555.7267.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102783555.7267.37.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The PIIX should be in legacy mode by default in which case it would be
> on IRQ 14/15 only. Can you post boot messages ?

This is interesting:

$ lspci -x -s 1f.1
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
00: 86 80 8a 24 07 00 80 02 02 8e 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 01 00 00 00 01 00 00 00
20: 41 18 00 00 00 00 10 e0 00 00 00 00 f7 10 38 83
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

The ICH3-M datasheet says offset 0x09 is the Programming Interface
register.  Default value is 0x8A (legacy on both), value here is 0x8E
(legacy on primary, native on secondary).  This mixed-mode setting
is noted as a disallowed combination in the datasheet.

So it looks like my BIOS is screwing me.  Where could/should I fix
this up?

-jim
