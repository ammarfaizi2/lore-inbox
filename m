Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVBCGzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVBCGzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVBCGzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:55:04 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:4204 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262825AbVBCGy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:54:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Possible bug in keyboard.c (2.6.10)
Date: Thu, 3 Feb 2005 01:54:51 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Roman Zippel <zippel@linux-m68k.org>,
       Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050130084154.GU8859@parcelfarce.linux.theplanet.co.uk> <200501301821.53924.dtor_core@ameritech.net>
In-Reply-To: <200501301821.53924.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502030154.52660.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 18:21, Dmitry Torokhov wrote:
> On Sunday 30 January 2005 03:41, Al Viro wrote:
> > On Sat, Jan 29, 2005 at 12:25:10PM +0100, Vojtech Pavlik wrote:
> > > I know. As I said, this is a problem I know about, and will be fixed. I
> > > was mainly interested whether anyone sees further problems in scenarios
> > > which don't include device addition/removal.
> > > 
> > > We already fixed this in serio, and input and gameport are next in the
> > > list.
> > 
> > OK, I'll bite.  What's to guarantee that no events will happen in
> > the middle of serio_unregister_port(), right after we'd done
> > serio_remove_pending_events()?
> 
> At this point serio is disconnected from driver and serio_interrupt
> will only queue rescans only if serio->registered. I guess I will need
> to protect change to serio->registered and take serio->lock to be
> completely in clear.
> 

Thinking about it some more - serio driver should take care of shutting
off interrupt delivery either in ->close() or ->stop() methods so we
don't really need to worry about having new events delivered here.

-- 
Dmitry
