Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSA0OiN>; Sun, 27 Jan 2002 09:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSA0OiE>; Sun, 27 Jan 2002 09:38:04 -0500
Received: from wrasse.demon.co.uk ([212.228.121.179]:41643 "EHLO
	wrasse.demon.co.uk") by vger.kernel.org with ESMTP
	id <S288050AbSA0Ohw>; Sun, 27 Jan 2002 09:37:52 -0500
Date: Sun, 27 Jan 2002 14:31:28 +0000 (GMT)
From: Martin Garton <martin@wrasse.demon.co.uk>
To: <Lionel.Bouton@inet6.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: sis.patch.20020123_1
Message-ID: <Pine.LNX.4.33.0201271412110.32403-100000@wrasse.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lionel,

Thanks for releasing your patch. I have tested it with my SiS737 chipset 
and noticed the following:

(please note - I may well not know what I am talking about)

My chipset is UDMA100 capable, but with your patch, no DMA was available 
by default (yes, I have CONFIG_BLK_DEV_IDEDMA=y)

I think I know whats wrong, but I'm not certain. I was expecting 
pci_init_sis5513() to find the device SiS735, but it finds SiS5513 
instead. (I understand that SiS735 is the host bridge, whereas SiS5513 is 
the ide interface) Is my thinking correct?

I did a nasty hack to get the device recognised as SiS735, and all is 
fine. I haven't posted my patch for this since I don't know the Right fix.

The second problem I had was an OOPS when doing "cat /proc/ide/sis" . I
think I have tracked this down, and I believe the attached patch fixes it.  
(applied on top of your patch, obviously)  (works for me, but please let
me know if it is nonsense.)

Regards,

Martin Garton.

--- linux-2.4.17-sispatches/drivers/ide/sis5513.c	Sun Jan 27 14:01:18 2002
+++ linux-2.4.17-martin/drivers/ide/sis5513.c	Sun Jan 27 14:06:25 2002
@@ -314,7 +314,8 @@
 		case ATA_16: /* confirmed */
 		case ATA_33:
 		case ATA_66: p += sprintf(p, active_time[(reg01 & 0x07) >> 4]); break;
-		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x70)]); break;
+		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x07)]); break;
+				      
 		case ATA_133:
 		default: p += sprintf(p, "133+ ?"); break;
 	}
@@ -324,7 +325,7 @@
 		case ATA_16:
 		case ATA_33:
 		case ATA_66: p += sprintf(p, active_time[(reg11 & 0x07) >> 4]); break;
-		case ATA_100: p += sprintf(p, active_time[(reg10 & 0x70)]); break;
+		case ATA_100: p += sprintf(p, active_time[(reg10 & 0x07)]); break;
 		case ATA_133:
 		default: p += sprintf(p, "133+ ?"); break;
 	}

