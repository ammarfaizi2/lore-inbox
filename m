Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTKGWSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTKGWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:41924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264378AbTKGPB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:01:27 -0500
Date: Fri, 7 Nov 2003 07:01:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.3.96.1031107090309.20991B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311070652080.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Bill Davidsen wrote:
> 
> I mentioned ide tapes and ZIP drives, Linus didn't mention how one gets
> around those.

The thing is, the non-ide-scsi interfaces really _should_ work. The fact
is, SG_IO ("send a SCSI command") just _works_.

However, right now only the CD-ROM driver exposes those commands. Why? 
Because nobody has apparently cared enough about those theoretical IDE 
tapes and ZIP drives.

In other words, they seem to "exist" in the same sense that soubdblaster 
CD-ROM users "exist". True in theory, but apparently only really useful 
for theoretical arguments.

Getting SCSI command support is not complicated: you add

	ret = scsi_cmd_ioctl(dev, cmd, arg);

to your ioctl routine. Of course, since so far nobody seems to have cared 
about anything but CD writing, it's not really tested for anything else.

		Linus

