Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVA2XgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVA2XgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVA2XgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:36:06 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:18261 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261601AbVA2XgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:36:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Possible bug in keyboard.c (2.6.10)
Date: Sat, 29 Jan 2005 18:35:59 -0500
User-Agent: KMail/1.7.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk> <20050129112510.GB2268@ucw.cz>
In-Reply-To: <20050129112510.GB2268@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291835.59597.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 06:25, Vojtech Pavlik wrote:
> On Sat, Jan 29, 2005 at 04:50:55AM +0000, Al Viro wrote:
> 
> > > I'm very sorry about the locking, but the thing grew up in times of
> > > kernel 2.0, which didn't require any locking. There are a few possible
> > 
> > Incorrect.  You have blocking allocations in critical areas and they
> > required locking all way back.
> 
> Ok. I see a problem where input_register_device() calls input handler
> connect methods, which do kmalloc(). This would be bad even on 2.0.
> 
> Anything else? I believe the ->open()/->release() methods are still
> protected.
> 

evdev, tsdev, mousedev, joydev need to protect their client lists because
interrupt could try to deliver event to already deleted device (client)
.
> > > races with device registration/unregistration, and it's on my list to
> > > fix that, however under normal operation there shouldn't be any need for
> > > locks, as there are no complex structures built that'd become
> > > inconsistent. 
> > 
> > Um-hm...  Vojtech, meet USB mouse; USB mouse, meet Vojtech.  Now watch
> > a disconnect and reconnect happening when luser suddenly gets overexcited
> > and jerks the wrong hand a bit too hard while browsing the most profitable
> > sort of website...
> 
> I know. As I said, this is a problem I know about, and will be fixed. I
> was mainly interested whether anyone sees further problems in scenarios
> which don't include device addition/removal.
> 
> We already fixed this in serio, and input and gameport are next in the
> list.
>

For the record I am still working on gameport conversion, just did not have
enough time lately...
 
> > > If you find scenarios which will lead to trouble in the event delivery
> > > system, please tell me, and I'll try to fix that as soon as possible.
> > 
> > See above.  Devices appearing and disappearing *are* normal.  
> 

-- 
Dmitry
