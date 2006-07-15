Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWGOMhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWGOMhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 08:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWGOMhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 08:37:53 -0400
Received: from rtr.ca ([64.26.128.89]:46805 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161028AbWGOMhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 08:37:52 -0400
Message-ID: <44B8E19E.2060904@rtr.ca>
Date: Sat, 15 Jul 2006 08:37:50 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: FYI: strange libata EH lines in dmesg once after every bootup
References: <20060714230801.GA6645@zeus.uziel.local> <44B8350E.9070409@rtr.ca> <20060715004845.GA26446@zeus.uziel.local>
In-Reply-To: <20060715004845.GA26446@zeus.uziel.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> > >the following happens every time after bootup, tested with freshly built
>>> > >2.6.18-rc1-mm2: 
>> > ..
>>> > >ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>>> > >ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
>>> > >ata1: EH complete
>> > ..
>> > 
>> > Those are S.M.A.R.T. commands.
>> > 
>> > Either your drive does not support S.M.A.R.T.,
>> > or you have not enabled it it with smartctl
> 
> 
> This drive model surely supports S.M.A.R.T. but maybe support in the
> driver is still underway. I just did a 
> 
> # smartctl --device=ata --smart=on --offlineauto=off --saveauto=on -T permissive /dev/sdb
> 
> and this is what I got:
> 
> smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF ENABLE/DISABLE COMMANDS SECTION ===
> SMART Enabled.
> Error SMART Enable Auto-save failed: Input/output error
> Smartctl: SMART Enable Attribute Autosave Failed.
> 
> SMART Automatic Offline Testing Disabled.

Okay.  Most likely your drive doesn't support the autosave features.

Just do "smartctl -d ata -a /dev/sdb" to see what it does support,
and then change the system startup scripts to not issue any unsupported
commands -- that'll get rid of those harmless boot time error messages.

Cheers
