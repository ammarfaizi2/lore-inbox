Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCaOsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCaOsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVCaOsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:48:14 -0500
Received: from mail1.upco.es ([130.206.70.227]:26293 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261470AbVCaOre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:47:34 -0500
Date: Thu, 31 Mar 2005 16:47:29 +0200
From: Romano Giannetti <romanol@upco.es>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
Message-ID: <20050331144728.GA21883@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050329132022.GA26553@pern.dea.icai.upco.es> <20050329170238.GA8077@pern.dea.icai.upco.es> <20050329181551.GA8125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050329181551.GA8125@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 08:15:51PM +0200, Pavel Machek wrote:

> I'd start with non-preempt 2.6.12-rc1, then remove all the
> unneccessary drivers, boot init=/bin/bash, and see what happens.

Tried it. Well, the good news is that now I can use correctly the serial
console. I discovered that if I use 

   console=ttyS0,115200n8 
         
all the message goes through the cable... but if I add (as per documentation)
console=tty0 too, something goes to the serial console and something no...
but well, I can live with it. 

The bad news is that with 2.6.12-rc1 (no preempt) swsusp fails to go. The
all thing that can capture the serial console is: 

Mar 31 16:14:52 rukbat kernel: [4294819.325000] usbcore: deregistering
driver usbhid
Mar 31 16:14:52 rukbat kernel: [4294819.537000] uhci_hcd 0000:00:07.2:
remove, state 1
Mar 31 16:14:52 rukbat kernel: [4294819.537000] usb usb1: USB disconnect,
address 1
Mar 31 16:14:52 rukbat kernel: [4294819.537000] usb 1-2: USB disconnect,
address 2
Mar 31 16:14:52 rukbat kernel: [4294819.714000] uhci_hcd 0000:00:07.2: USB
bus 1 deregistered
Mar 31 16:14:52 rukbat kernel: [4294819.729000] uhci_hcd 0000:00:07.3:
remove, state 1
Mar 31 16:14:52 rukbat kernel: [4294819.729000] usb usb2: USB disconnect,
address 1
Mar 31 16:14:52 rukbat kernel: [4294819.819000] uhci_hcd 0000:00:07.3: USB
bus 2 deregistered
Mar 31 16:14:52 rukbat kernel: [4294819.861000] usbcore: deregistering
driver usbmouse
[4294821.492000] Stopping tasks:
===============================================================================|
[4294821.505000] Freeing memory... done (44548 pages freed)

And then stops dead. One thing I noticed: the "rotating bar" is now much
more slow than before (although the total time before "done" is not changed
a lot, it seems). Could be a hint? 

the full log (42k) is here
http://www.dea.icai.upco.es/romano/linux/swsusp/2612-rc1.log

I tried with init=/bin/bash, same thing, here: 
http://www.dea.icai.upco.es/romano/linux/swsusp/2612-rc1-2nd.log

To compare, this is a full log of boot, suspend and successful resume 
with 2.6.11:
http://www.dea.icai.upco.es/romano/linux/swsusp/2611-rg.log

it's not vanilla, it has the following patch applied, but I tested with and
without it and nothing change (that is, all is OK in this kernel)

http://www.dea.icai.upco.es/romano/linux/config-2.6.11-rg/patch-no3851.id4516

Well... what can I do now (apart doing some real work)? I can try to debug
why 2.6.11 with preempt fail, or continue on 2.6.12? I am willing to help!

Thank you for your help,

          Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
