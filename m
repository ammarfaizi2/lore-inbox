Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbQKFWLj>; Mon, 6 Nov 2000 17:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbQKFWL3>; Mon, 6 Nov 2000 17:11:29 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50506
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129599AbQKFWLT>; Mon, 6 Nov 2000 17:11:19 -0500
Date: Tue, 7 Nov 2000 00:03:38 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: kkeil@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/isdn/hisax/nj_{s,u}.c fails compilation (2.4.0-test10)
Message-ID: <20001107000338.E726@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

If I compile a 2.4.0-test10 kernel without pci support I get a compile
error in both drivers/isdn/hisax/nj_u.c and nj_s.c. The patch below
fixes these in what I hope is the Right Way. But I am not sure, so
Linus is not cc'ed on this. Please forward to him if the patches are
correct.

--- linux-240-t10-clean/drivers/isdn/hisax/nj_s.c	Sat Nov  4 23:25:26 2000
+++ linux/drivers/isdn/hisax/nj_s.c	Mon Nov  6 23:52:00 2000
@@ -148,11 +148,10 @@
 		return(0);
 	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
 
-	for ( ;; )
-	{
-
 #if CONFIG_PCI
 
+	for ( ;; )
+	{
 		if (!pci_present()) {
 			printk(KERN_ERR "Netjet: no PCI bus present\n");
 			return(0);
--- linux-240-t10-clean/drivers/isdn/hisax/nj_u.c	Sat Nov  4 23:25:26 2000
+++ linux/drivers/isdn/hisax/nj_u.c	Mon Nov  6 23:51:50 2000
@@ -150,11 +150,10 @@
 		return(0);
 	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
 
-	for ( ;; )
-	{
-
 #if CONFIG_PCI
 
+	for ( ;; )
+	{
 		if (!pci_present()) {
 			printk(KERN_ERR "NETspider-U: no PCI bus present\n");
 			return(0);

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

You know how dumb the average guy is?  Well, by  definition, half
of them are even dumber than that.
            -- J.R. "Bob" Dobbs 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
