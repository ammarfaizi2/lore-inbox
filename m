Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280645AbRKBKnY>; Fri, 2 Nov 2001 05:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280646AbRKBKnO>; Fri, 2 Nov 2001 05:43:14 -0500
Received: from CPE-61-9-148-175.vic.bigpond.net.au ([61.9.148.175]:8953 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S280645AbRKBKnF>; Fri, 2 Nov 2001 05:43:05 -0500
Message-ID: <3BE276AF.5B417378@eyal.emu.id.au>
Date: Fri, 02 Nov 2001 21:34:23 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols [PATCH]
In-Reply-To: <200111020954.fA29sf413054@riker.skynet.be>
Content-Type: multipart/mixed;
 boundary="------------F45EAEDA2F6041D7B6485122"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F45EAEDA2F6041D7B6485122
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

jarausch@belgacom.net wrote:
> 
> Hi,
> 
> trying to build 2.4.14-pre7 breaks with the error message
> depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
> depmod:         unlock_page

Not an official patch, but as the symbol was introduced into
mm/filemap.c
and is used widely through linux/mm.h, I guess it should simply be
exported.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------F45EAEDA2F6041D7B6485122
Content-Type: text/plain; charset=us-ascii;
 name="2.4.14-pre7-filemap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.14-pre7-filemap.patch"

--- linux/mm/filemap.c.orig	Fri Nov  2 21:28:22 2001
+++ linux/mm/filemap.c	Fri Nov  2 21:28:48 2001
@@ -785,6 +785,7 @@
 	if (waitqueue_active(&(page)->wait))
 	wake_up(&(page)->wait);
 }
+EXPORT_SYMBOL(unlock_page);
 
 /*
  * Get a lock on the page, assuming we need to sleep

--------------F45EAEDA2F6041D7B6485122--

