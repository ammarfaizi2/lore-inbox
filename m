Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUCQMFC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 07:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbUCQMFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 07:05:02 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:19608 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S261388AbUCQME6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 07:04:58 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-4.tower-9.messagelabs.com!1079525099!6591687
X-StarScan-Version: 5.1.15; banners=arcom.com,-,-
Subject: Re: [PATCH] PXA255 LCD Driver
From: Ian Campbell <icampbell@arcom.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
References: <1079518182.13373.27.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171137410.21104@waterleaf.sonytel.be>
	 <1079521633.13370.39.camel@icampbell-debian>
	 <Pine.GSO.4.58.0403171215050.21104@waterleaf.sonytel.be>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1079525185.13373.143.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 12:06:26 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was trying too (I mostly copied the i810 driver). How wrong did I get
> > it? I'm willing to rework it to make it the same as the standard.
> 
> Take a look at drivers/video/modedb.c and fb_find_mode().

Ah, I had seen that, but it doesn't seem to be very appropriate for an
LCD controller in an embedded environment. TFT and STN (STN in
particular) displays don't often fit into any of the standard mode
definitions. There's also several settings which aren't in the DB, such
as pixel clock polarity, dual vs. single panel STN etc.

I quite often get asked to make some arbitrary panel which a customer
picked up somewhere dirt cheap to work, it is very useful to be able to
give each of the parameters explicitly, even if they do not correspond
to a mode listed in the DB. 

I could make the code use the same XRESxYRES-DEPTH syntax though since
the 2.4 version did (by copying the parsing code from fb_find_mode()), I
just changed it to match i810fb for the 2.6 port.

I had considered extending the modedb stuff to support the requirements
of embedded LCD controller drivers and to encompass a db of LCD panels
by part number (Kconfig selectable, something like the NLS support
perhaps) containing the extra options that you can have -- but I wasn't
sure if it was something that would be useful only to me or to all
embedded LCD driver authors.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been checked for all viruses by MessageLabs Virus Control Centre.
