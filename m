Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTKERuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTKERuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:50:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:26765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263069AbTKERuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:50:02 -0500
Date: Wed, 5 Nov 2003 09:49:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Matt <dirtbird@ntlworld.com>, <herbert@gondor.apana.org.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
In-Reply-To: <20031105173907.GA27922@ucw.cz>
Message-ID: <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Vojtech Pavlik wrote:
> 
> We could save the bootup mouse settings (the mouse will tell us) and
> restore them after we go trough all the probing if desired.

That sounds like a good idea. At least for the mice that we didn't 
recognize, that otherwise get basically "random" commands.

How about something like this:

 - if "mouse_noext" is set (which implies that we won't be doing any 
   probing), we also don't set rate/precision unless the user asked us.

   Thus "psmouse_noext" becomes the "ultra-safe" setting. We still want to 
   have some way to set things like wheel etc info by hand later on (ie as
   a response to the user _telling_ us what mouse it is), but that's a
   more long-range plan.

 - if we do probing, we first ask the mouse for its current details, and 
   we restore the thing by default afterwards. That at least should give 
   us 2.4.x behaviour unless the mouse is broken (and for broken mice 
   you'd just have to have "mouse_noext").

   Again, long-term we'd want to have the possibility of tweaking the 
   results later even with the autodetection.

Does that sound like a reasonable plan?

		Linus

