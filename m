Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUJLWY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUJLWY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUJLWY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:24:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5308 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267973AbUJLWYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:24:24 -0400
Date: Tue, 12 Oct 2004 15:23:43 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [HID] Fix hiddev devfs oops
Message-ID: <20041012152343.5b70cbd3@lembas.zaitcev.lan>
In-Reply-To: <20041012212153.GA24663@gondor.apana.org.au>
References: <20041005124914.GA1009@gondor.apana.org.au>
	<20041011172147.GA3066@logos.cnet>
	<20041012212153.GA24663@gondor.apana.org.au>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 07:21:54 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > > Marcelo, the same fix is needed in 2.4 as well.
> > 
> > Would be nice to have a version which applies to 2.4 also.
> 
> I did include a 2.4 patch in that email :)

Herbert, I'm sorry for the wait. Marcelo asked me to take care of this,
but I kept postponing it because I wanted to look closer, and this and
that... It looks entirely reasonable and my hid devices continue to work,
but I haven't tested hiddev (UPS or something ?).

-- Pete

diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/hid-core.c linux-2.4.28-pre3-usb/drivers/usb/hid-core.c
--- linux-2.4.28-pre3/drivers/usb/hid-core.c	2004-09-12 14:24:09.000000000 -0700
+++ linux-2.4.28-pre3-usb/drivers/usb/hid-core.c	2004-10-12 15:15:40.000000000 -0700
@@ -1459,8 +1459,8 @@ static int __init hid_init(void)
 
 static void __exit hid_exit(void)
 {
-	hiddev_exit();
 	usb_deregister(&hid_driver);
+	hiddev_exit();
 }
 
 module_init(hid_init);
