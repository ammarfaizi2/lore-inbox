Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSBLG5T>; Tue, 12 Feb 2002 01:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290803AbSBLG5J>; Tue, 12 Feb 2002 01:57:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43017 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290797AbSBLG47>;
	Tue, 12 Feb 2002 01:56:59 -0500
Date: Tue, 12 Feb 2002 07:56:36 +0100
From: Jens Axboe <axboe@suse.de>
To: reddog83 <reddog83@chartermi.net>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Message-ID: <20020212075636.T729@suse.de>
In-Reply-To: <auto-000058815980@front2.chartermi.net> <001701c1b312$24448ca0$0c00a8c0@diemos> <auto-000058467594@front1.chartermi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auto-000058467594@front1.chartermi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11 2002, reddog83 wrote:
> Paul-
> That is understandable. I had  the same guess as you when I made this patch. 
> Why is ths synclink.c driver using DMA Mapping. After I took that line out I 
> was fine becuase my system is fine. 

The "real" fix for synclink is just something like this, afaics.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.275   -> 1.276  
#	drivers/char/synclink.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/12	axboe@burns.home.kernel.dk	1.276
# synclink is an ISA-only driver, so just use isa_virt_to_bus to make
# it work
# --------------------------------------------
#
diff -Nru a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c	Tue Feb 12 07:55:54 2002
+++ b/drivers/char/synclink.c	Tue Feb 12 07:55:54 2002
@@ -60,8 +60,6 @@
 #  define BREAKPOINT() { }
 #endif
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #define MAX_ISA_DEVICES 10
 #define MAX_PCI_DEVICES 10
 #define MAX_TOTAL_DEVICES 20
@@ -3985,7 +3983,7 @@
 		if ( info->buffer_list == NULL )
 			return -ENOMEM;
 			
-		info->buffer_list_phys = virt_to_bus(info->buffer_list);
+		info->buffer_list_phys = isa_virt_to_bus(info->buffer_list);
 	}
 
 	/* We got the memory for the buffer entry lists. */
@@ -4096,7 +4094,7 @@
 				kmalloc(DMABUFFERSIZE, GFP_KERNEL | GFP_DMA);
 			if ( BufferList[i].virt_addr == NULL )
 				return -ENOMEM;
-			phys_addr = virt_to_bus(BufferList[i].virt_addr);
+			phys_addr = isa_virt_to_bus(BufferList[i].virt_addr);
 		}
 		BufferList[i].phys_addr = phys_addr;
 	}

-- 
Jens Axboe

