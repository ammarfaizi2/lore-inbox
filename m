Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVESVat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVESVat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 17:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVESVat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 17:30:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:17099 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261262AbVESVag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 17:30:36 -0400
Date: Thu, 19 May 2005 14:35:51 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Yani Ioannou <yani.ioannou@gmail.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-ID: <20050519213551.GA806@kroah.com>
References: <2538186705051703479bd0c29@mail.gmail.com> <e9iUj0EZ.1116327879.1515720.khali@localhost> <2538186705051704181a70dbbf@mail.gmail.com> <253818670505172136613abb43@mail.gmail.com> <20050519220235.3946f880.khali@linux-fr.org> <20050519205222.GA311@kroah.com> <20050519225712.02137a47.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050519225712.02137a47.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 10:57:12PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> > > If we are into code refactoring and driver size shrinking, you may
> > > want to take a look at the following patch, which makes it87 even
> > > smaller (from 18976 bytes down to 16992 bytes on my system) and IMHO
> > > more cleaner.
> > 
> > But this doesn't reduce the binary size of the module, right?
> 
> It does, as I just said. The benefit is probably mainly due to the
> introduction of loops around device_create_file() calls. The patch
> reduces the number of calls (in the binary) from 59 to 20.

Ah, sorry, I mistook that for a code decrease and not binary decrease.

> > No, I hate HEAD and TAIL macros.  This really isn't buying you much
> > code savings, you could do it yourself with the __ATTR() macro
> > yourself with the same ammount of code I bet...
> >
> > Or use the new macro that Yani created, that will make it even smaller
> > :)
> 
> Agreed. This was really a quick hack, not meant for inclusion. Maybe I
> should have polished it a bit more before I dared sending it. I'll do so
> next time, sorry for the noise.

No, don't feel like this was noise at all, it wasn't.  I was just
commenting on the patch, letting you know that it was a great place to
start, but it might be tweaked a bit in places.

Don't worry about polishing stuff up before sending it in, you have seen
some of my patches, right?  :)

Also, there is a neat trick that you can do every once in a while if you
use it sparingly.  Propose a patch that you know is wrong, just to get
someone else (usually the maintainer of the area) to do it correctly as
they don't like your way at all.  It's very effective when used in small
doses.

Hm, which makes me want to go look at trying to convert those attributes
to an array right now...

thanks,

greg k-h
