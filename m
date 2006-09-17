Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWIRMJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWIRMJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWIRMJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:09:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:64448 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964997AbWIRMJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:09:12 -0400
Date: Sun, 17 Sep 2006 09:05:24 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc6-mm2
Message-ID: <20060917160524.GA6326@suse.de>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com> <20060914214038.GA32352@suse.de> <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com> <20060914223638.GA547@suse.de> <6bffcb0e0609151335wce499b0nb3e39bdc26b4b433@mail.gmail.com> <20060915215042.GA15175@suse.de> <6bffcb0e0609160514t6a57b98fw478c7438df970c21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609160514t6a57b98fw478c7438df970c21@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 02:14:52PM +0200, Michal Piotrowski wrote:
> On 15/09/06, Greg KH <gregkh@suse.de> wrote:
> >On Fri, Sep 15, 2006 at 10:35:37PM +0200, Michal Piotrowski wrote:
> >> Good news, I can't reproduce this bug with 
> >CONFIG_USB_MULTITHREAD_PROBE=n.
> >
> >Great, thanks for letting me know.
> >
> >> BTW. This might be a problem with CONFIG_PCI_MULTITHREAD_PROBE=y
> >> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/bug.jpg
> >
> >That looks odd.  What device is your root partition on?
> 
> SATA HDD.

Which type of SATA device?  Is it ata_piix perhaps?

If so, you need the hack below to enable these devices to work properly.
I can't vouch for any problems that might happen with the patch, but
I've been using it successfully for quite a while.

thanks,

greg k-h

---------------------
Subject: Driver: multi-threaded hacks

 - Fix "issue" with ata_piix doing multi-threaded boot

Use at your own risk.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/ata_piix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/scsi/ata_piix.c
+++ gregkh-2.6/drivers/scsi/ata_piix.c
@@ -1024,7 +1024,7 @@ static int __init piix_init(void)
 	if (rc)
 		return rc;
 
-	in_module_init = 0;
+//	in_module_init = 0;  multi-threaded probe doesn't like this...
 
 	DPRINTK("done\n");
 	return 0;
