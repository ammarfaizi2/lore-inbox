Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbREQTAt>; Thu, 17 May 2001 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbREQTAj>; Thu, 17 May 2001 15:00:39 -0400
Received: from jalon.able.es ([212.97.163.2]:31220 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261490AbREQTAb>;
	Thu, 17 May 2001 15:00:31 -0400
Date: Thu, 17 May 2001 21:00:23 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
Message-ID: <20010517210023.A1052@werewolf.able.es>
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu> <20010517204616.K754@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010517204616.K754@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Thu, May 17, 2001 at 20:46:16 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.17 Ingo Oeser wrote:
> On Thu, May 17, 2001 at 05:45:38PM +0100, Alan Cox wrote:
> > 2.4.4-ac10
> 
> I think someone forgot this little return. It removes the
> following warning:
> 
> serial.c:4208: warning: control reaches end of non-void function
> 
> 
> --- linux-2.4.4-ac10/drivers/char/serial.c	Thu May 17 20:41:05 2001
> +++ linux-2.4.4-ac10-ioe/drivers/char/serial.c	Thu May 17 20:35:53 2001
> @@ -4205,6 +4205,7 @@
>  {
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	schedule_timeout(HZ/10);
> +   return 0;
>  }
>  

And a pair more:

--- linux-2.4.4-ac10/include/linux/raid/md_k.h.orig	Thu May 17 19:35:41
2001
+++ linux-2.4.4-ac10/include/linux/raid/md_k.h	Thu May 17 19:36:15 2001
@@ -38,6 +38,8 @@
 		case RAID5:		return 5;
 	}
 	panic("pers_to_level()");
+
+	return 0;
 }
 
 extern inline int level_to_pers (int level)
--- linux-2.4.3-ac12/drivers/scsi/aic7xxx/aic7xxx_osm.h.orig	Sun Apr 22
10:21:55 2001
+++ linux-2.4.3-ac12/drivers/scsi/aic7xxx/aic7xxx_osm.h	Mon Apr 23
10:55:58 2001
@@ -843,10 +843,10 @@
 		pci_read_config_dword(pci, reg, &retval);
 		return (retval);
 	}
-	default:
-		panic("ahc_pci_read_config: Read size too big");
-		/* NOTREACHED */
 	}
+	panic("ahc_pci_read_config: Read size too big");
+	/* NOTREACHED */
+   return 0;
 }
 
 static __inline void ahc_pci_write_config(ahc_dev_softc_t pci,

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac9 #4 SMP Mon May 14 11:22:40 CEST 2001 i686

