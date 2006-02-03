Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946017AbWBCWgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946017AbWBCWgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946020AbWBCWgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:36:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50702 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946017AbWBCWgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:36:17 -0500
Date: Fri, 3 Feb 2006 23:36:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Martin Michlmayr <tbm@cyrius.com>, Al Viro <viro@ftp.linux.org.uk>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: [2.6 patch] make INPUT a bool
Message-ID: <20060203223615.GU4408@stusta.de>
References: <20060124181945.GA21955@deprecation.cyrius.com> <d120d5000601241508l1a93aae7ubdf8206209be405c@mail.gmail.com> <20060124231409.GA29982@deprecation.cyrius.com> <200601250004.06543.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601250004.06543.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:04:06AM -0500, Dmitry Torokhov wrote:
> On Tuesday 24 January 2006 18:14, Martin Michlmayr wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-24 18:08]:
> > > > More interesting question: is pis^H^H^Hsysfs interaction in there safe for
> > > > modular code?
> > > 
> > > The core should be safe, at least I was trying to make it this way, so
> > > if you see something wrong - shout. Locking is another question
> > > though...
> > 
> > So do you want an updated patch using _GPL to export the symbols or to
> > change CONFIG_INPUT to boolean?
> 
> I guess having input core as a module does not make much sense, so
> we should change CONFIG_INPUT to be boolean _and_ clean up the core
> code removing module unloading support.

Is the patch below what you were thinking of?

> Dmitry

cu
Adrian


<--  snip  -->


Make INPUT a bool.

INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
make that much sense to make it modular.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/Kconfig |    2 +-
 drivers/input/input.c |    8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig.old	2006-02-03 22:42:18.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/input/Kconfig	2006-02-03 22:42:29.000000000 +0100
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
+	bool "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
--- linux-2.6.16-rc1-mm5-full/drivers/input/input.c.old	2006-02-03 22:42:41.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/drivers/input/input.c	2006-02-03 22:47:44.000000000 +0100
@@ -984,12 +984,4 @@
 	return err;
 }
 
-static void __exit input_exit(void)
-{
-	input_proc_exit();
-	unregister_chrdev(INPUT_MAJOR, "input");
-	class_unregister(&input_class);
-}
-
 subsys_initcall(input_init);
-module_exit(input_exit);

