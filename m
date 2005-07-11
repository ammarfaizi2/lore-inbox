Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVGKAxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVGKAxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVGKAxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:53:54 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:7650 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262050AbVGKAxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:53:53 -0400
Message-Id: <42D1C33B.40606@khandalf.com>
Date: Mon, 11 Jul 2005 02:54:19 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] SCSI Printer on AIC78XX without SCSI Terminator
References: <200507101921.36332.gustavo@compunauta.com>
In-Reply-To: <200507101921.36332.gustavo@compunauta.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: c4b6044ad8122de057e672dd28c27008
X-Transmit-Date: Monday, 11 Jul 2005 2:54:45 +0200
X-Message-Uid: 0000b49cec9d9ee7000000020000000042d1c356000241ed00000001000bc188
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@84-73-132-32.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 32701; Body=2
	Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, normal (non-differential) SCSI is an OpenCollector bus design
which simply wont work without a terminator and is designed to use
exactly two(2) terminators, one at each end of the bus, these both
provide a pull up and terminate the bus to prevent reflections. Also
the longer and faster the bus the more you depend on correct termination
e.g. 130 ohm - +3.3V

For much more detail, including external terminators please see

http://www.scsita.org/aboutscsi/SCSI_Termination_Tutorial.html

Second, there is usually a built in terminator in the AIC7xxx
adaptor, usually enabled in the SCSI BIOS.

Also check your device for negotiable SCSI options, eg SYNC, OFFSET

Gustavo Guillermo Pérez wrote:
> Hello, I was tried to use a SCSI Printer, onto a AIC78XX (old and new driver), 
> when driver load, it recognise the Scanner, the Printer and Panel, but may be 
> the copier doesn't have an internal terminator, and driver hangs forever 
> discovering unexistent 4th device. I do not wish to dissasemble the copier to 
> solder the terminator, and I never deal with SCSI HW. Kernel I was tried: 
> 2.6.7, 2.4.23. but I think the driver does not change from 2.6.7 to 2.6.12.
> 
> I see the doc about this driver but I can't figure out wich of a lot options 
> can help to not try to discover more than 3 devices... I'll have a chance to 
> play with this machine the next week, then I'm taking ideas.
> 
> aic7xxx=seltime:2
> this option wait for answer but the device 4º waits forever...
> aic7xxx=no_reset
> I don't....
> aic7xxx=override_term
> mmmmmm
> ...
> 
> The new driver support cmdline args?
> 
> If someone can share comment I would appreciate it
> 
> cheers

-- 
mit freundlichen Grüßen, Brian.

