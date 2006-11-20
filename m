Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934246AbWKTPmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934246AbWKTPmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934248AbWKTPmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:42:20 -0500
Received: from vsmtp12.tin.it ([212.216.176.206]:56707 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S934246AbWKTPmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:42:18 -0500
Date: Mon, 20 Nov 2006 16:42:09 +0100
From: The Peach <smartart@tiscali.it>
To: linux-kernel@vger.kernel.org
Subject: bug? VFAT copy problem
Message-ID: <20061120164209.04417252@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
I've recently found a problem with the VFAT module.
I'm working on a gentoo box with kernel 2.6.17 gentoo patched (recently upgraded from 2.6.15)

I've got a samba share on a reiser partition and a daily cron will copy its content to an external usb disk with vfat file system. The copy is done via bash scripting and some checks are done before mirroring the files.
btw _some_ random files are copied lowering all chars in the file name.

Here is an example:

# pwd
/home/b/dir
# ls -l
-rwxr-xr-x 1 b users 676389 Aug 10  2004 DSCN5967(1).JPG
-rwxr-xr-x 1 b users 710090 Aug 10  2004 DSCN5968(1).JPG
-rwxr-xr-x 1 b users 732903 Aug 10  2004 DSCN5981.JPG.rem.2006-10-27-1543 
-rwxr-xr-x 1 b users 622595 Aug 10  2004 DSCN5982.JPG.rem.2006-10-27-1543 
# cp -v * /mnt/iomega/dir/ 
`DSCN5967(1).JPG' -> `/mnt/iomega/dir/DSCN5967(1).JPG' 
`DSCN5968(1).JPG' -> `/mnt/iomega/dir/DSCN5968(1).JPG' 
`DSCN5981.JPG.rem.2006-10-27-1543' -> `/mnt/iomega/dir/DSCN5981.JPG.rem.2006-10-27-1543'
`DSCN5982.JPG.rem.2006-10-27-1543' -> `/mnt/iomega/dir/DSCN5982.JPG.rem.2006-10-27-1543' 
# ls -l /mnt/iomega/dir/ 
total 2784 
-rwxr-xr-x 1 b users 676389 Oct 27 16:55 DSCN5967(1).JPG 
-rwxr-xr-x 1 b users 710090 Oct 27 16:55 DSCN5968(1).JPG 
-rwxr-xr-x 1 b users 732903 Oct 27 16:55 dscn5981.jpg.rem.2006-10-27-1543 
-rwxr-xr-x 1 b users 622595 Oct 27 16:55 dscn5982.jpg.rem.2006-10-27-1543

even if 'cp' gives correct destination names, an 'ls' shows that this
is not always true.

Here is a second quick experiment I've made:

# pwd
/home/b/dir
# cp -v DSCN5981.JPG.rem.2006-10-27-1543 DSCN5981.JPG.rem.9999-99-99-9999 
`DSCN5981.JPG.rem.2006-10-27-1543' -> `DSCN5981.JPG.rem.9999-99-99-9999' 
# cp -v DSCN5981.JPG.rem.9999-99-99-9999 /mnt/iomega/dir/
`DSCN5981.JPG.rem.9999-99-99-9999' -> `/mnt/iomega/dir/DSCN5981.JPG.rem.9999-99-99-9999' 
# ls -l /mnt/iomega/dir/ 
total 2784 
-rwxr-xr-x 1 b users 676389 Oct 27 16:55 DSCN5967(1).JPG 
-rwxr-xr-x 1 b users 710090 Oct 27 16:55 DSCN5968(1).JPG
-rwxr-xr-x 1 b users 732903 Oct 27 17:01 DSCN5981.JPG.rem.9999-99-99-9999 
-rwxr-xr-x 1 b users 732903 Oct 27 16:55 dscn5981.jpg.rem.2006-10-27-1543 
-rwxr-xr-x 1 b users 622595 Oct 27 16:55 dscn5982.jpg.rem.2006-10-27-1543

if the code will not show up correctly you can find the full code
listings at this url:
http://forums.gentoo.org/viewtopic-t-511205-highlight-.html
(thread in italian, the code is quite self explaining)

Thanks in advance, I can do any further test if you need, and provide any other info on the system.

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
