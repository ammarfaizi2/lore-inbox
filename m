Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131066AbRAWWnE>; Tue, 23 Jan 2001 17:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbRAWWmo>; Tue, 23 Jan 2001 17:42:44 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58453
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130098AbRAWWmh>; Tue, 23 Jan 2001 17:42:37 -0500
Date: Tue, 23 Jan 2001 23:42:30 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drives/scsi/tmscsim.c: check_region -> request_region (241p9)
Message-ID: <20010123234230.A9514@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Forgot to cc lk. If anyone have comments please cc garloff@suse.de.
Thanks.)

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch makes drives/scsi/tmscsim.c use request_region
instead of check_region+request_region. It applies cleanly against
ac10 and with a little fuzz against 241p9.

Please comment.



--- linux-ac10-clean/drivers/scsi/tmscsim.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/tmscsim.c	Sat Jan 20 23:17:29 2001
@@ -2088,13 +2088,11 @@
     
     pACB = (PACB) psh->hostdata;
     
-    if (check_region (io_port, psh->n_io_port))
+    if (!request_region (io_port, psh->n_io_port, "tmscsim"))
 	{
 	    printk(KERN_ERR "DC390: register IO ports error!\n");
 	    return( -1 );
 	}
-    else
-	request_region (io_port, psh->n_io_port, "tmscsim");
 
     DC390_read8_ (INT_Status, io_port);		/* Reset Pending INT */
 

----- End forwarded message -----

-- 
        Rasmus(rasmus@jaquet.dk)

"The obvious mathematical breakthrough would be development of an easy way
to factor large prime numbers." 
  -- Bill Gates, The Road Ahead, Viking Penguin (1995)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
