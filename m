Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314449AbSDXDTG>; Tue, 23 Apr 2002 23:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314498AbSDXDTF>; Tue, 23 Apr 2002 23:19:05 -0400
Received: from surf.viawest.net ([216.87.64.26]:59854 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S314449AbSDXDTF>;
	Tue, 23 Apr 2002 23:19:05 -0400
Date: Tue, 23 Apr 2002 20:19:00 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: mikej163@attbi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  make xconfig fails on link
Message-ID: <20020424031900.GA6731@wizard.com>
In-Reply-To: <20020423232908.33CF556A5A@C242326-a.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.9 (i686)
X-uptime: 8:10pm  up 1 day, 39 min,  2 users,  load average: 0.09, 0.03, 0.01
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 04:29:00PM -0700, Michael D. Johnson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> [1] make xconfig fails to link active during fresh install/rebuild on 2.5.9  
> this worked on 2.5.7 but not here.
> [2] see above
> [3] Key Word:  xconfig
> [4] Version: 2.4.8-34.1mdk #1 Mon Nov 19 12:40:39 MST 2001 i686 unknown
> [Duron 700 Mhz]
> [5] Error reported :  make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-new/linux-2.5.9/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/isdn/Config.in: 10: incorrect argument
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-new/linux-2.5.9/scripts'
> make: *** [xconfig] Error 2

        I had the same problem with xconfig when I rolled 2.5.9. A bit more 
looking into it made me wonder about the conditional of Config.in on that 
line. Currently shows:

if [ "$CONFIG_ISDN_BOOL" == "y" ]; then

        I reversed this condition to make it != "y", and it worked. See below 
for patch. I'm not sure if this is correct, because I'm not that familiar with 
it (though I should!) but it made make xconfig work for me again. YMMV.

                                                        BL.

--- linux/drivers/isdn/Config.in.borked	Tue Apr 23 20:12:58 2002
+++ linux/drivers/isdn/Config.in	Mon Apr 22 18:46:45 2002
@@ -7,7 +7,7 @@
 if [ "$CONFIG_NET" != "n" ]; then
    bool 'ISDN support' CONFIG_ISDN_BOOL
 
-   if [ "$CONFIG_ISDN_BOOL" == "y" ]; then
+   if [ "$CONFIG_ISDN_BOOL" != "y" ]; then
       mainmenu_option next_comment
       comment 'Old ISDN4Linux'

 
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

