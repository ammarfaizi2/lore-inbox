Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUDQCZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUDQCZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:25:52 -0400
Received: from 228.17.30.61.isp.tfn.net.tw ([61.30.17.228]:32539 "EHLO
	cm-msg-02.cmedia.com.tw") by vger.kernel.org with ESMTP
	id S261897AbUDQCZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:25:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]: cmpci 6.82 released
Date: Sat, 17 Apr 2004 09:52:27 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D438@cm-msg-02.cmedia.com.tw>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: cmpci 6.82 released
Thread-Index: AcQj84x0hDT/S+zzTA+f1VXb3SK0xAAKn50S
From: =?big5?B?Qy5MLiBUaWVuIC0gpdCp08Kn?= <cltien@cmedia.com.tw>
To: "Adrian Bunk" <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you mean __devinit should be __devexit for cm_remove? Indeed, when I first change it, this question rose. There are still many other driver in kernel 2.4.25 use the same way. But I checked the driver in kernel 2.6 tree use the __devexit already for correct semantic meaning. I made following change, thanks for your correction.

retrieving revision 6.82
retrieving revision 6.83
diff -a -u -r6.82 -r6.83
--- cmpci.c	13 Apr 2004 16:02:58 -0000	6.82
+++ cmpci.c	17 Apr 2004 01:39:20 -0000	6.83
@@ -3275,7 +3275,7 @@
 MODULE_DESCRIPTION("CM8x38 Audio Driver");
 MODULE_LICENSE("GPL");
 
-static void __devinit cm_remove(struct pci_dev *dev)
+static void __devexit cm_remove(struct pci_dev *dev)
 {
 	struct cm_state *s = pci_get_drvdata(dev);
 
@@ -3332,12 +3332,12 @@
        .name	 = "cmpci",
        .id_table = id_table,
        .probe	 = cm_probe,
-       .remove	 = cm_remove
+       .remove	 = __devexit_p(cm_remove),
 };
 
 static int __init init_cmpci(void)
 {
-	printk(KERN_INFO "cmpci: version $Revision: 6.82 $ time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "cmpci: version $Revision: 6.83 $ time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&cm_driver);
 }


-----Original Message-----
From:	Adrian Bunk [mailto:bunk@fs.tum.de]
Sent:	2004/4/16 [星期五] 下午 04:43
To:	C.L. Tien - 田承禮
Cc:	linux-kernel@vger.kernel.org
Subject:	Re: [PATCH]: cmpci 6.82 released
On Thu, Apr 15, 2004 at 01:15:31AM +0800, C.L. Tien - ?????? wrote:
> Hi,
> 
> I made several changes for cmpci.6.77, so the version is now 6.82.
> 
> The patch is mostly from kernel 2.6, which change to support newer gcc,
> fix possible security hole. I also use the same include files for both
> kernel versions.
> 
> The cmpci-6.82-patch2.4.tar.bz2 is made from official kernel 2.4.25, but should  be able to patch other 2.4 kernel.
> 
> The cmpci-6.82-patch2.6.tar.bz2 is from official kernel 2.6.5, it will
> show error when patch cmpci.c for kernel 2.6.4 or earlier, that's ok.

There seem to be some bugs in the __{,dev}{init,exit} changes.

E.g. in the 2.6 patch:

  static void __devinit cm_remove(struct pci_dev *dev)
                   ^^^^


> Sincerely,
> ChenLi Tien


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed





