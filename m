Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292687AbSCDSp3>; Mon, 4 Mar 2002 13:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292682AbSCDSpS>; Mon, 4 Mar 2002 13:45:18 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:26804 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S292674AbSCDSpI>; Mon, 4 Mar 2002 13:45:08 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5 videodev redesign -- #3
Date: Mon, 4 Mar 2002 14:54:32 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020302151538.A7839@bytesex.org> <iss.28ea.3c83389c.370f5.1@mailout.lrz-muenchen.de> <slrna86gll.lh9.kraxel@bytesex.org>
In-Reply-To: <slrna86gll.lh9.kraxel@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <iss.60a3.3c83c0b2.401f5.2@mailout.lrz-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 4. März 2002 10:47 schrieb Gerd Knorr:
> > > Comments?  Bugs?  I plan to feed this to Linus soon ...
> >
> >  Hi,
> >
> >  it seems to me that you are not holding the BKL during
> >  the open method of the individual driver. This will
> >  cause races with unplugging on some USB cameras.
>
> What race exactly?

open() can race with videodev_unregister()

> I don't want videodev.c know details about the devices, it doesn't
> belong there.  If a usb cam needs locking, the usb cam's open() function
> should do that then.  I'll prefare fixing the usb drivers instead of
> calling driver->open() with BKL held.

Problematic. I found no other solution than the BKL.

	Regards
		Oliver
