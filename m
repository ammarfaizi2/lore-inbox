Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281841AbRKWAwJ>; Thu, 22 Nov 2001 19:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRKWAwA>; Thu, 22 Nov 2001 19:52:00 -0500
Received: from [213.98.126.44] ([213.98.126.44]:27785 "HELO mitica.trasno.org")
	by vger.kernel.org with SMTP id <S281841AbRKWAvz>;
	Thu, 22 Nov 2001 19:51:55 -0500
To: "Ishak Hartono" <lotus@upnaway.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: anyone got the same problem with DIGITAL 21143 network card ?
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <001201c1735c$9ac546d0$0b01a8c0@lotus>
Date: 23 Nov 2001 01:50:26 +0100
Message-ID: <m2u1vml38t.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "ishak" == Ishak Hartono <lotus@upnaway.com> writes:

ishak> I tried to compile 2.4.14 and successfully detect the digital 21143 network
ishak> card, however, i can't ping out

ishak> this is just a curiosity, because it works with my 2.2.17 kernel

ishak> the reason why i didn't move to 2.4.x yet because i got this problem with
ishak> 2.4.5 as well and gave it a try again on 2.4.14 kernel

ishak> anyone know what should i check in the system  other than blaming on the
ishak> kernel ?

Could you check if this patch makes your card work?

It works for me.

Later, Juan.

--- linux/drivers/net/tulip/21142.c.orig	Mon Nov  5 20:50:27 2001
+++ linux/drivers/net/tulip/21142.c	Mon Nov  5 21:26:40 2001
@@ -188,8 +188,9 @@
 			int i;
 			for (i = 0; i < tp->mtable->leafcount; i++)
 				if (tp->mtable->mleaf[i].media == dev->if_port) {
+					int startup = ! ((tp->chip_id == DC21143 && tp->revision == 65));
 					tp->cur_index = i;
-					tulip_select_media(dev, 1);
+					tulip_select_media(dev, startup);
 					setup_done = 1;
 					break;
 				}




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
