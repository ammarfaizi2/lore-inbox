Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDUNxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTDUNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:53:54 -0400
Received: from host160-52.pool62211.interbusiness.it ([62.211.52.160]:45454
	"EHLO penny.tippete.net") by vger.kernel.org with ESMTP
	id S261281AbTDUNxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:53:53 -0400
To: linux-kernel@vger.kernel.org
Subject: booting 2.5.68 with root on software raid and devfs?
Reply-To: Pierfrancesco Caci <pf@tippete.net>
From: Pierfrancesco Caci <ik5pvx@home.tippete.net>
Date: Mon, 21 Apr 2003 16:05:53 +0200
Message-ID: <87smsceyim.fsf@home.tippete.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

anyone has an idea why 2.5.68 can't boot (it sends a panic, can't
mount root on md(9,0) message and dies) off a raid1+devfs setup that
works perfectly on 2.4.x ?

I have the suspect that something in the naming of devices has
changed, but I can't find any reference by googling around.

Here's my setup, as 2.4.21-pre7 sees it:

root@penny:~ # mount            
/dev/md/0 on / type ext3 (rw)
proc on /proc type proc (rw)
/dev/penny/niglia on /usr type ext3 (rw)
/dev/penny/viola on /var type ext3 (rw)
/dev/penny/tippete on /home type ext3 (rw)
/dev/kim/felix on /usr/src type ext3 (rw)
/dev/kim/isidoro on /home/ftp/pub type ext3 (rw,noatime)
/dev/gattaia/pink on /scratch type ext3 (rw)
tmpfs on /dev/shm type tmpfs (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)


root@penny:~ # cat /proc/mdstat 
Personalities : [raid0] [raid1] 
read_ahead 1024 sectors
md0 : active raid1 ide/host0/bus1/target1/lun0/part1[1] ide/host0/bus0/target0/lun0/part1[0]
      248896 blocks [2/2] [UU]
      
md1 : active raid1 ide/host0/bus1/target1/lun0/part2[1] ide/host0/bus0/target0/lun0/part2[0]
      39896576 blocks [2/2] [UU]
      
unused devices: <none>

root@penny:~ # head /etc/lilo.conf
#disk=/dev/hda
# bios=0x80
#disk=/dev/hdd
# bios=0x81
boot=/dev/md0
root=/dev/md0
raid-extra-boot=/dev/hda,/dev/hdd
#compact
#linear
lba32


Any ideas where to start looking ?

Thanks

Pf

-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.21-pre7 #1 Sat Apr 12 09:12:33 CEST 2003 i686 GNU/Linux

