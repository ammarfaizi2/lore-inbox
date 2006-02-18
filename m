Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWBRAsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWBRAsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWBRAsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:48:47 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:45195 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751495AbWBRAsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:48:46 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: kbuild: Section mismatch warnings
Date: Fri, 17 Feb 2006 16:48:37 -0800
User-Agent: KMail/1.7.1
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, dwmw2@infradead.org
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060218000921.GA15894@suse.de>
In-Reply-To: <20060218000921.GA15894@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171648.38003.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 4:09 pm, Greg KH wrote:
> On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:

> > WARNING: drivers/usb/gadget/g_ether.o - Section mismatch: reference to .init.text from .data between 'eth_driver' (at offset 0x10) and 'stringtab'
> > WARNING: drivers/usb/gadget/g_file_storage.o - ... etc ...
>
> David, these all look like they are due to the calls in the
> drivers/usb/gadget/epautoconf.c file from functions within the gadget
> drivers.  It looks like it's all safe, but can you verify that the bind
> callback is finished before module_init() exits?

If they just usb_gadget_register_driver(), that's how it's defined to
work yes.  (Though a spec lawyer might want more explicit language ...)


> And if so, we should mark the bind functions __init also, to prevent
> this from being flagged in the future.

And the unbind functions __exit/__exit_p()?  Smaller runtime footprints
are good.  I don't like leaving the driver->init() method invalid, which
is I think why I didn't do that before, but saving space is the right
thing to do.


> > WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text from .data between '' (at offset 0x0) and 'isp116x_hc_driver'
> 
> This looks like the isp116x_remove function just needs to get the looney
> __init_or_module marking of of it.  Again, David, do you agree?

Right; that marking is for infrastructure, not drivers.

- Dave
