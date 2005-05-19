Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVESU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVESU5z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVESU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:57:54 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:41226 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261257AbVESU5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:57:03 -0400
Date: Thu, 19 May 2005 22:57:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Yani Ioannou <yani.ioannou@gmail.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050519225712.02137a47.khali@linux-fr.org>
In-Reply-To: <20050519205222.GA311@kroah.com>
References: <2538186705051703479bd0c29@mail.gmail.com>
	<e9iUj0EZ.1116327879.1515720.khali@localhost>
	<2538186705051704181a70dbbf@mail.gmail.com>
	<253818670505172136613abb43@mail.gmail.com>
	<20050519220235.3946f880.khali@linux-fr.org>
	<20050519205222.GA311@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > If we are into code refactoring and driver size shrinking, you may
> > want to take a look at the following patch, which makes it87 even
> > smaller (from 18976 bytes down to 16992 bytes on my system) and IMHO
> > more cleaner.
> 
> But this doesn't reduce the binary size of the module, right?

It does, as I just said. The benefit is probably mainly due to the
introduction of loops around device_create_file() calls. The patch
reduces the number of calls (in the binary) from 59 to 20.

> You know, we do have arrays of attributes that can be registered with
> a single call...
> 
> I'd recommend using that over this mess anyday :)

Yeah, I'll take a look into this at some point. This should make the
code even more readable and efficient.

> No, I hate HEAD and TAIL macros.  This really isn't buying you much
> code savings, you could do it yourself with the __ATTR() macro
> yourself with the same ammount of code I bet...
>
> Or use the new macro that Yani created, that will make it even smaller
> :)

Agreed. This was really a quick hack, not meant for inclusion. Maybe I
should have polished it a bit more before I dared sending it. I'll do so
next time, sorry for the noise.

-- 
Jean Delvare
