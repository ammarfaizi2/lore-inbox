Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267757AbVBDDwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267757AbVBDDwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267754AbVBDDwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:52:55 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:50781 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267734AbVBDDwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 22:52:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stephen Evanchik <evanchsa@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Date: Thu, 3 Feb 2005 22:52:44 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net>
In-Reply-To: <200502031934.16642.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032252.45309.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 19:34, Dmitry Torokhov wrote:
> On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> > Vojtech,
> > 
> > Here is a patch that exposes the IBM TrackPoint's extended properties
> > as well as scroll wheel emulation.
> > 
> > 
> 
> Hi,
> 
> Very nice although I have a couple of comments.
> 
> >  /*
> > + * Try to initialize the IBM TrackPoint
> > + */
> > +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > +		psmouse->vendor = "IBM";
> > +		psmouse->name = "TrackPoint";
> > + 
> > +		return PSMOUSE_PS2;
> 
> Why PSMOUSE_PS2? Reconnect will surely not like it.
>

OK, I have read the code once again, and saw that you have special
handling within PS/2 protocol based on model constant. Please set
psmouse type to PSMOUSE_TRACKPOINT instead of model and provide full
protocol handler, like ALPS, Synaptics and Logitech do. Trackpoint
is different and complex enough to warrant it.

-- 
Dmitry
