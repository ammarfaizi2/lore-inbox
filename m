Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSIWTqQ>; Mon, 23 Sep 2002 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSIWTqQ>; Mon, 23 Sep 2002 15:46:16 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:7181 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261370AbSIWTqO>; Mon, 23 Sep 2002 15:46:14 -0400
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
In-Reply-To: <20020923192700.GA18707@kroah.com>
To: Greg KH <greg@kroah.com>
Date: Mon, 23 Sep 2002 21:51:15 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17tZEh-0000qG-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> On Sun, Sep 22, 2002 at 06:08:30PM +0200, Marek Michalkiewicz wrote:
> > None of this happens without the US_FL_MODE_XLATE flag...
> They don't use that flag. :)

OK - "test WP failed" is harmless (unless there are read-only CF
cards...), but it would still be nice to track down that bug as it
might affect other devices (those that require MODE_XLATE).

In the meantime, may I ask you nicely to add this to 2.4.20
drivers/usb/storage/unusual_devs.h ?

/* Datafab KECF-USB / Sagatek DCS-CF (Datafab DF-UG-07 chip).
 * Submitted by Marek Michalkiewicz <marekm@amelek.gda.pl>.
 * Needed for FIX_INQUIRY.  Only revision 1.13 tested.
 * See also http://martin.wilck.bei.t-online.de/#kecf .
 */
UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
		"Datafab",
		"KECF-USB",
		US_SC_SCSI, US_PR_BULK, NULL,
		US_FL_FIX_INQUIRY ),

Note that this uses the normal US_PR_BULK protocol (not US_PR_DATAFAB -
tried that one too, didn't work) so this shouldn't be conditional on
CONFIG_USB_STORAGE_DATAFAB, just always included.  It seems that newer
Datafab devices are slightly less broken^Wunusual than the old ones ;)

I say "Datafab" because the name "Sagatek" (http://www.sagatek.com.tw/)
appears only on the packaging.  There is a Datafab chip inside, and
"KECF-USBG" is actually printed on the PCB inside...

Thanks,
Marek

