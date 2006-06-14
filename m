Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWFNXNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWFNXNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWFNXNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:13:12 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:10964 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S964998AbWFNXNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:13:10 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mike Miller <mike.miller@hp.com>
Subject: [PATCH 6/7] CCISS: remove parens around return values
Date: Wed, 14 Jun 2006 17:12:52 -0600
User-Agent: KMail/1.8.3
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200606141707.27404.bjorn.helgaas@hp.com>
In-Reply-To: <200606141707.27404.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141712.52532.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typical Linux style is "return -EINVAL", not "return(-EINVAL)".

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: rc6-mm2/drivers/block/cciss.c
===================================================================
--- rc6-mm2.orig/drivers/block/cciss.c	2006-06-14 16:18:37.000000000 -0600
+++ rc6-mm2/drivers/block/cciss.c	2006-06-14 16:18:39.000000000 -0600
@@ -677,7 +677,7 @@
 		pciinfo.board_id = host->board_id;
 		if (copy_to_user(argp, &pciinfo,  sizeof( cciss_pci_info_struct )))
 			return  -EFAULT;
-		return(0);
+		return 0;
 	}	
 	case CCISS_GETINTINFO:
 	{
@@ -687,7 +687,7 @@
 		intinfo.count = readl(&host->cfgtable->HostWrite.CoalIntCount);
 		if (copy_to_user(argp, &intinfo, sizeof( cciss_coalint_struct )))
 			return -EFAULT;
-                return(0);
+                return 0;
         }
 	case CCISS_SETINTINFO:
         {
@@ -703,7 +703,7 @@
 
 		{
 //			printk("cciss_ioctl: delay and count cannot be 0\n");
-			return( -EINVAL);
+			return -EINVAL;
 		}
 		spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
 		/* Update the field, and then ring the doorbell */ 
@@ -723,7 +723,7 @@
 		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
 		if (i >= MAX_IOCTL_CONFIG_WAIT)
 			return -EAGAIN;
-                return(0);
+                return 0;
         }
 	case CCISS_GETNODENAME:
         {
@@ -735,7 +735,7 @@
 			NodeName[i] = readb(&host->cfgtable->ServerName[i]);
                 if (copy_to_user(argp, NodeName, sizeof( NodeName_type)))
                 	return  -EFAULT;
-                return(0);
+                return 0;
         }
 	case CCISS_SETNODENAME:
 	{
@@ -767,7 +767,7 @@
 		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
 		if (i >= MAX_IOCTL_CONFIG_WAIT)
 			return -EAGAIN;
-                return(0);
+                return 0;
         }
 
 	case CCISS_GETHEARTBEAT:
@@ -778,7 +778,7 @@
                 heartbeat = readl(&host->cfgtable->HeartBeat);
                 if (copy_to_user(argp, &heartbeat, sizeof( Heartbeat_type)))
                 	return -EFAULT;
-                return(0);
+                return 0;
         }
 	case CCISS_GETBUSTYPES:
         {
@@ -788,7 +788,7 @@
                 BusTypes = readl(&host->cfgtable->BusTypes);
                 if (copy_to_user(argp, &BusTypes, sizeof( BusTypes_type) ))
                 	return  -EFAULT;
-                return(0);
+                return 0;
         }
 	case CCISS_GETFIRMVER:
         {
@@ -799,7 +799,7 @@
 
                 if (copy_to_user(argp, firmware, sizeof( FirmwareVer_type)))
                 	return -EFAULT;
-                return(0);
+                return 0;
         }
         case CCISS_GETDRIVVER:
         {
@@ -809,7 +809,7 @@
 
                 if (copy_to_user(argp, &DriverVer, sizeof( DriverVer_type) ))
                 	return -EFAULT;
-                return(0);
+                return 0;
         }
 
 	case CCISS_REVALIDVOLS:
@@ -826,7 +826,7 @@
  		if (copy_to_user(argp, &luninfo,
  				sizeof(LogvolInfo_struct)))
  			return -EFAULT;
- 		return(0);
+ 		return 0;
  	}
 	case CCISS_DEREGDISK:
 		return rebuild_lun_table(host, disk);
@@ -934,7 +934,7 @@
 		{
 			kfree(buff);
 			cmd_free(host, c, 0);
-			return( -EFAULT);	
+			return -EFAULT;	
 		} 	
 
 		if (iocommand.Request.Type.Direction == XFER_READ)
@@ -949,7 +949,7 @@
                 }
                 kfree(buff);
 		cmd_free(host, c, 0);
-                return(0);
+                return 0;
 	} 
 	case CCISS_BIG_PASSTHRU: {
 		BIG_IOCTL_Command_struct *ioc;
@@ -1101,7 +1101,7 @@
 		}
 		kfree(buff_size);
 		kfree(ioc);
-		return(status);
+		return status;
 	}
 	default:
 		return -ENOTTY;
@@ -1546,7 +1546,7 @@
 
 	drv->LunID = 0;
 	}
-	return(0);
+	return 0;
 }
 
 static int fill_cmd(CommandList_struct *c, __u8 cmd, int ctlr, void *buff,
@@ -1639,7 +1639,7 @@
 		default:
 			printk(KERN_WARNING
 				"cciss%d:  Unknown Command 0x%c\n", ctlr, cmd);
-			return(IO_ERROR);
+			return IO_ERROR;
 		}
 	} else if (cmd_type == TYPE_MSG) {
 		switch (cmd) {
@@ -1807,7 +1807,7 @@
 	pci_unmap_single( h->pdev, (dma_addr_t) buff_dma_handle.val,
 			c->SG[0].Len, PCI_DMA_BIDIRECTIONAL);
 	cmd_free(h, c, 0);
-        return(return_status);
+        return return_status;
 
 }
 static void cciss_geometry_inquiry(int ctlr, int logvol,
@@ -1942,7 +1942,7 @@
 		if (done == FIFO_EMPTY)
 			schedule_timeout_uninterruptible(1);
 		else
-			return (done);
+			return done;
 	}
 	/* Invalid address to tell caller we ran out of time */
 	return 1;
@@ -2019,7 +2019,7 @@
 
 	if ((c = cmd_alloc(info_p, 1)) == NULL) {
 		printk(KERN_WARNING "cciss: unable to get memory");
-		return(IO_ERROR);
+		return IO_ERROR;
 	}
 	status = fill_cmd(c, cmd, ctlr, buff, size, use_unit_num,
 		log_unit, page_code, scsi3addr, cmd_type);
@@ -2154,7 +2154,7 @@
 		do_cciss_intr(0, info_p, NULL);
 #endif
 	cmd_free(info_p, c, 1);
-	return (status);
+	return status;
 } 
 /*
  * Map (physical) PCI mem into (virtual) kernel space
@@ -3088,7 +3088,7 @@
 
 	i = alloc_cciss_hba();
 	if(i < 0)
-		return (-1);
+		return -1;
 
 	hba[i]->busy_initializing = 1;
 
@@ -3230,7 +3230,7 @@
 		add_disk(disk);
 	}
 
-	return(1);
+	return 1;
 
 clean4:
 #ifdef CONFIG_CISS_SCSI_TAPE
@@ -3252,7 +3252,7 @@
 clean1:
 	hba[i]->busy_initializing = 0;
 	free_hba(i);
-	return(-1);
+	return -1;
 }
 
 static void __devexit cciss_remove_one (struct pci_dev *pdev)
