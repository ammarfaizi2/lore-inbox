Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJ0QWk>; Sat, 27 Oct 2001 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJ0QWb>; Sat, 27 Oct 2001 12:22:31 -0400
Received: from zero.tech9.net ([209.61.188.187]:2827 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S273305AbRJ0QWT>;
	Sat, 27 Oct 2001 12:22:19 -0400
Subject: Re: [PATCH] 2.4.13-ac2: Appletalk Config Screwed
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15xVd9-0003bg-00@the-village.bc.nu>
In-Reply-To: <E15xVd9-0003bg-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 12:22:52 -0400
Message-Id: <1004199773.3272.34.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-27 at 11:44, Alan Cox wrote:
> I can't duplicate the problem described

Perhaps you need to have no reference to CONFIG_ATALK in your config? 
At the very least, you should be able to go into Network Devices ->
Appletalk and see that if CONFIG_ATALK=n then the suboptions for the
devices are settable, and of course they should not be.  I don't know
why you don't see the errors on exit from make xconfig or the repeated
questions from oldconfig...

I also found another problem: there are two statements for CONFIG_ATALK,
the second one should be removed as the resulting options are in an if
block anyhow.  This results in double CONFIG_ATALK entries in your
config now that the gross if's were reorganized.  Updated patch
attached.

diff -u linux-2.4.13-ac2/drivers/net/appletalk/Config.in linux/drivers/net/appletalk/Config.in
--- linux-2.4.13-ac2/drivers/net/appletalk/Config.in	Fri Oct 26 15:47:50 2001
+++ linux/drivers/net/appletalk/Config.in	Sat Oct 27 12:09:57 2001
@@ -1,11 +1,8 @@
 #
 # Appletalk driver configuration
 #
-
-if [ "$CONFIG_ATALK" != "n" ]; then
-   mainmenu_option next_comment
+mainmenu_option next_comment
    comment 'Appletalk devices'
-   bool 'Appletalk interfaces support' CONFIG_ATALK
    if [ "$CONFIG_ATALK" != "n" ]; then
       dep_tristate '  Apple/Farallon LocalTalk PC support' CONFIG_LTPC $CONFIG_ATALK
       dep_tristate '  COPS LocalTalk PC support' CONFIG_COPS $CONFIG_ATALK
@@ -19,5 +16,4 @@
 	 bool '    Appletalk-IP to IP Decapsulation support' CONFIG_IPDDP_DECAP
       fi
    fi
-   endmenu
-fi
+endmenu

	Robert Love

