Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTEHWwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbTEHWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:52:50 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:34178 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262210AbTEHWws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:52:48 -0400
Date: Fri, 9 May 2003 01:03:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030508230337.GA139@elf.ucw.cz>
References: <20030507152856.GF412@elf.ucw.cz> <1052323484.9817.14.camel@rth.ninka.net> <20030508203313.GA2787@elf.ucw.cz> <20030508.134300.122085520.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508.134300.122085520.davem@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    From: Pavel Machek <pavel@ucw.cz>
>    Date: Thu, 8 May 2003 22:33:14 +0200
> 
>    What about this one: redefine it to (*ioctl)( ...., unsigned *long*,
>    unsinged long). That means we can add 
>    
>    #define IOCTL_COMPAT 0x1 0000 0000
> 
> Bzzt!  Doesn't work on 32-bit.  COMPAT does not mean 64-bit-->32-bit
> translations, stop thinking about the compat layer in this way.
> 
> It is a generic environment translation system.
> 
> Eventually we can use it for things like IBCS2 and stuff like that.

I... do not think so. 

You'd then need

.compat_linux32_ioctl
.compat_IBCS2_ioctl
...

I do not think that is doable.

> Suggest something sane like defining a macro such as
> "compat_task(tsk)" that can be tested by various bits of
> code.

That makes more sense. Unfortunately, that means that case "okay, it
is compatible" can not be told from "we did not bother to check
compat_task()". :-(. Nor do I see a transition phase.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
