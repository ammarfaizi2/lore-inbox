Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUCOMUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUCOMUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:20:25 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:49794 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262545AbUCOMUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:20:20 -0500
Date: Mon, 15 Mar 2004 13:21:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
Message-ID: <20040315122127.GA776@ucw.cz>
References: <1079097936.1837.102.camel@localhost> <20040313121027.GA7434@ucw.cz> <1079349195.1721.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079349195.1721.14.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 12:13:16PM +0100, Soeren Sonnenburg wrote:

> > > I can probably give more infos as xmon is compiled in the kernel here.
> >  
> > Is this reproducible, or does it happen only rarely? I suspect it could
> > be a race somewhere ...
> 
> It happens reproducably even when booting without X (and it always the
> very same oops I get). However it seems to only happen in connection
> with pbbuttonsd which has to be reloaded (causing it to rescan for
> changed usb hid devices) via hotplug... The oops happens when I remove a
> device, which in turn causes hotplug to make pbbuttonsd rescan for
> added/removed devices which then somehow triggers this oops.
> 
> So could this be pbbuttonsd's fault :? or is it indeed some kernel bug ?

It's a kernel bug, definitely. And it's interesting to know that it
happens on device _removal_, that means HID could be freeing the device
structs earlier than evdev is stopping to use them.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
