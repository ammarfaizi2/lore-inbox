Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUJLVWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUJLVWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUJLVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:22:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:48900 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267829AbUJLVWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:22:25 -0400
Date: Wed, 13 Oct 2004 07:21:54 +1000
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [HID] Fix hiddev devfs oops
Message-ID: <20041012212153.GA24663@gondor.apana.org.au>
References: <20041005124914.GA1009@gondor.apana.org.au> <20041011172147.GA3066@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20041011172147.GA3066@logos.cnet>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2004 at 02:21:47PM -0300, Marcelo Tosatti wrote:
> On Tue, Oct 05, 2004 at 10:49:14PM +1000, Herbert Xu wrote:
> > 
> > There is a long-standing devfs_unregister oops in hid/hiddev.  It's
> > caused by hid calling hiddev_exit before unregistering itself which
> > in turn calls hiddev_disconnect.
> > 
> > hiddev_exit removes the directory which contains the hiddev devices.
> > Therefore it needs to be called after the hiddev devices have been
> > disconnected.
> > 
> > This patch fixes that.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > 
> > Marcelo, the same fix is needed in 2.4 as well.
> 
> Would be nice to have a version which applies to 2.4 also.

I did include a 2.4 patch in that email :)

Here it is again.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p-2.4"

===== drivers/usb/hid-core.c 1.30 vs edited =====
--- 1.30/drivers/usb/hid-core.c	2004-08-08 18:59:53 +10:00
+++ edited/drivers/usb/hid-core.c	2004-10-05 22:33:52 +10:00
@@ -1459,8 +1459,8 @@
 
 static void __exit hid_exit(void)
 {
-	hiddev_exit();
 	usb_deregister(&hid_driver);
+	hiddev_exit();
 }
 
 module_init(hid_init);

--WIyZ46R2i8wDzkSu--
