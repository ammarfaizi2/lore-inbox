Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131583AbRAWWMc>; Tue, 23 Jan 2001 17:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRAWWMX>; Tue, 23 Jan 2001 17:12:23 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:52053
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130098AbRAWWMD>; Tue, 23 Jan 2001 17:12:03 -0500
Date: Tue, 23 Jan 2001 23:11:57 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/g_NCR5380.c: check_*_region -> request_*_region (241p9)
Message-ID: <20010123231157.F607@jaquet.dk>
In-Reply-To: <20010123004026.M602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010123004026.M602@jaquet.dk>; from rasmus@jaquet.dk on Tue, Jan 23, 2001 at 12:40:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:40:26AM +0100, Rasmus Andersen wrote:

(This is another updated patch with the comments from the earlier mail
still valid.)


--- linux-ac10-clean/drivers/scsi/g_NCR5380.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/g_NCR5380.c	Tue Jan 23 21:05:44 2001
@@ -361,7 +361,7 @@
 	        }
 	    else
 	        for(i=0; ports[i]; i++) {
-	            if ((!check_region(ports[i], 16)) && (inb(ports[i]) == 0xff))
+			if ((inb(ports[i]) == 0xff) && request_region(ports[i], NCR5380_region_size, "ncr5380"))
 	                break;
 		}
 	    if (ports[i]) {
@@ -379,15 +379,10 @@
 	    } else
 	        continue;
 	}
-
-	request_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
 #else
-	if(check_mem_region(overrides[current_override].NCR5380_map_name,
-		NCR5380_region_size))
+	if(!request_mem_region(overrides[current_override].NCR5380_map_name,
+		NCR5380_region_size, "ncr5380"))
 		continue;
-	request_mem_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
 #endif
 	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
 	if(instance == NULL)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

That lowdown scoundrel deserves to be kicked to death by a jackass, and
I'm just the one to do it. -A congressional candidate in Texas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
