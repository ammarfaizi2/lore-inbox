Return-Path: <linux-kernel-owner+w=401wt.eu-S1030302AbXAKMSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbXAKMSG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbXAKMSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:18:05 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:46979 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030302AbXAKMSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:18:04 -0500
X-Greylist: delayed 2393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 07:18:04 EST
Date: Thu, 11 Jan 2007 12:38:12 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, Bjoern Buerger <bbu@pengutronix.de>
Subject: Mounting tmpfs with symbolic gid doesn't work
Message-ID: <20070111113812.GD29495@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mounting tmpfs with gid=<symbolic-group> doesn't work on recent kernels
any more; the same with uid=<symbolic-username> works fine:

rsc@isonoe:~$ mkdir troet
rsc@isonoe:~$ sudo mount -t tmpfs -ogid=rsc none troet/
mount: wrong fs type, bad option, bad superblock on none,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so
rsc@isonoe:~/svn/ptxdist-trunk$ dmesg | tail -n 1 
tmpfs: Bad value 'rsc' for mount option 'gid'
rsc@isonoe:~$ sudo mount -t tmpfs -ogid=1006 none troet/
rsc@isonoe:~$ mount | grep troet
none on /home/rsc/troet type tmpfs (rw,gid=1006)
rsc@isonoe:~$ ls -ld troet/
drwxrwxrwt 2 root 1006 40 Jan 11 12:32 troet/
rsc@isonoe:~$ sudo umount troet/
rsc@isonoe:~$ sudo mount -t tmpfs -ouid=1006 none troet/
rsc@isonoe:~$ sudo umount troet/
rsc@isonoe:~$ sudo mount -t tmpfs -ouid=rsc none troet/
rsc@isonoe:~$ ls -ld troet/
drwxrwxrwt 2 rsc root 40 Jan 11 12:33 troet/
rsc@isonoe:~$ sudo umount troet/

Tested with 2.6.19-rc6, the behaviour seems to have worked until at
least 2.6.16. Does anyone have an idea?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

