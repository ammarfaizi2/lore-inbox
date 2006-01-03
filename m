Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWACC3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWACC3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 21:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWACC3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 21:29:40 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:34500 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1750798AbWACC3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 21:29:39 -0500
Date: Mon, 02 Jan 2006 21:29:13 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple	PowerBooks
In-reply-to: <20060102224640.GB27317@hansmi.ch>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>,
       stelian@popies.net
Message-id: <1136255354.27583.77.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051225212041.GA6094@hansmi.ch>
 <200512252304.32830.dtor_core@ameritech.net>
 <20051231235124.GA18506@hansmi.ch>
 <1136084207.4635.86.camel@localhost.localdomain>
 <20060102224640.GB27317@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 23:46 +0100, Michael Hanselmann wrote:

> +static int powerbook_fkeysfirst = 1;
> +module_param_named(pb_fkeysfirst, powerbook_fkeysfirst, bool, 0644);
> +MODULE_PARM_DESC(powerbook_fkeysfirst, "Use fn special keys only while pressing fn");
> +
> +static int powerbook_enablefnkeys = 1;
> +module_param_named(pb_enablefnkeys, powerbook_enablefnkeys, bool, 0644);
> +MODULE_PARM_DESC(powerbook_enablefnkeys, "Enable fn special keys");
> +
> +static int powerbook_enablekeypad = 1;
> +module_param_named(pb_enablekeypad, powerbook_enablekeypad, bool, 0644);
> +MODULE_PARM_DESC(powerbook_enablekeypad, "Enable keypad keys");
> +#endif

I think these should be inverted to, something like
pbook_disable_keypad, pbook_disable_fnkeys and pbook_fnfirst.

Two reasons. First, it just makes more sense to pass a module param to
turn something on (doing powerbook_enablekeypad=0 isn't as intuitive as
pbook_disable_keypad=1). Second reason is that since these are static
vars, defaulting them to uninitialized (leaving them in the bss, as 0)
reduces binary size.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

