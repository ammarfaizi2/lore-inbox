Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWAXGB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWAXGB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 01:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWAXGB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 01:01:27 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:57966 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030343AbWAXGB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 01:01:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: uevent buffer overflow in input layer
Date: Tue, 24 Jan 2006 01:01:19 -0500
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1137973421.4907.14.camel@localhost.localdomain> <20060124050346.GC22848@kroah.com>
In-Reply-To: <20060124050346.GC22848@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240101.21238.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 00:03, Greg KH wrote:
> On Mon, Jan 23, 2006 at 10:43:41AM +1100, Benjamin Herrenschmidt wrote:
> > Current -git as of today does this on an x86 box with a logitech USB
> > keyboard:
> > 
> > (the $$$ is debug stuff I added to print_modalias(), size is the size
> > passed in and "Total len" is the value of "len" before returning). We
> > end up overflowing, thus we pass a negative size to snprintf which
> > causes the WARN_ON. Bumping the uevent buffer size in lib/kobject_uevent.c
> > from 1024 to 2048 seems to fix the oops and /dev/input/mice is now properly
> > created and works (it doesn't without the fix, X fails and we end up back
> > in console with a dead keyboard).
> > 
> > I'm not sure it's the correct solution as I'm not too familiar with the
> > uevent code though, so I'll let you guys decide on the proper approach.
> 
> Yes, input has some big strings, I'd recommend bumping it up like you
> suggest.
> 
> Care to make up a patch as you found the problem and should get the
> credit?  :)
> 

Actually, is it too late to convert modalias data to the same format
(bitmap) we are using in /proc/bus/input/devices (keeping cutting key
info at KEY_MIN_INTERESTING)? It looks like it will be more compact
and let us keep 1024 bytes buffer...

-- 
Dmitry
