Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBCRhZ>; Mon, 3 Feb 2003 12:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBCRhZ>; Mon, 3 Feb 2003 12:37:25 -0500
Received: from velli.mail.jippii.net ([195.197.172.114]:31695 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S266932AbTBCRhX>; Mon, 3 Feb 2003 12:37:23 -0500
Message-ID: <23369880.1044294368501.JavaMail.flexy@nic.fi>
Date: Mon, 3 Feb 2003 19:46:08 +0200 (EET)
From: flexy@nic.fi
To: linux-kernel@vger.kernel.org
Subject: Keyboard/console lockups, Magic SysRQ fails [2.4.20(-pre3)]
Mime-Version: 1.0
Content-Type: text/plain; Charset=iso-8859-1; Format=Flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Jippii webmail - http://www.jippiigroup.com/
X-Originating-IP: 213.139.183.245
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've started testing linux 2.4.x on this hardware around last May, I 
have had this problem ever since.

Problem is that keyboard goes unresponsive and console stops updating 
every now and then, seems that this happens randomly. Kernel keeps doing 
other stuff, like I can play oggs from another machine that are being 
shared by samba. Hitting caps lock key seems to fix this most of the 
time, sometimes on the first try, othertimes I have to hit it like dozen 
or more times. Sometimes I'm not patient enough to keep hitting the caps 
lock long enough, so I figure it does not help everytime. Only thing I 
can imagine is related to this, I have _once_ seen on the logs something 
like "Missing ACK from keyboard several times, noisy keyboard cable?" I 
don't know if this is relevant. I have tried this with 1 ps2 keyboard 
and with MS keyboard that has both ps2 and usb connectors. No matter 
what keyboard/connector I use, the stucking still happens. IIRC, around 
2.4.19 this problem might have eased a little.

Now, I have ditched the other OS from this machine, changed it totally 
to linux and purchased 1Gb NIC. Unless I'm going blind, it seems that 
there is no support for this card in 2.4.19, so I have to use 2.4.20. 
And it seems that the lockings happen more often when the kernel is NOT 
2.4.19. I haven't really tried with 2.4.19 anymore, since I need to try 
to keep the NATed win machine on that 1Gb NIC connected to net and my 
wife happy that way...

I've tried with 2.4.20 and 2.4.20-pre3, both of them have this 
keyboard/console stucking thing. Plus, it seems that I've got a new 
problem. Now kernel goes totally stuck sometimes. Magic keys does not 
respond all of the times, other stuff (NAT, Samba) stops working. After 
this kind of lockups the filesystem (ext3) needed a check. (Here I 
propably screwed up by doing 'mount -n -o remount,rw /' before using 
fsck) After one run of fsck, it suggests to run it again and when doing 
it, IIRC, it plays the journal. After this, fsck finds a truckload of 
errors, fixing them results in massive filesystem corruption (missing 
/sbin and stuff like that).

OK, I realize now that using fsck on mounted filesystem was propably not 
wise, but I think I have gotten away with that in the past without any 
problems... OK, after 2 or 3 massive filesystem damages and a reinstalls 
I went with ext2 and continued trying to find the problem (and stopped 
running fsck on mounted filesystem). I followed the "KISS" rule and
stripped everything I don't absolutely need out of the kernel. Same 
stucking problems continues, now without filesystem corruptions (fsck at 
boot fixes successfully things). One time I could ssh to that stucked 
box, it seemed that X (4.2) was stuck, was not able to stop it. Also
'shutdown -r now' failed. OK, I replaced X with 3.3.6, which should be 
stable... On the very first boot, total lock up, not able to ssh to it. 
OK, I removed X alltogether and ran 'chmod 644 <service>' at 
/etc/init.d/ on the services I know I don't need while trying to find 
the problem. Yet these lockups happen every now and then. Mostly of the 
caps lock -curable things.

I have a parallel null modem cable, I could use it to find more info 
about lock ups, with some detailed info...
If you can give me any instructions how to help me give more useful 
information, I would be happy to follow them.

Here is information on my system:

Motherboard: MSI K7D Master-L, with built-in LAN. (e100 module)

http://www.msi.com.tw/program/products/server/svr/pro_svr_detail.php?UID=73&MODEL=MS-6501

512MB DDR memory, with ECC, ECC correcting enabled in BIOS.
2*XP1600+ cpus
Intel PRO/1000 MT 1Gbps NIC with 82540 controller (e1000 module)
S3 PCI display adapter
Adaptec ATA RAID 2400A, risc powered raid5 with 4*60GB IBM 60GXP hard disks

and then now unused components during the fault finding:
LG CED-8080B CDRW
ALPS DC544C 4x4 CD-changer

Flexy

P.S. Using automounter with the changer has got the system stuck tree 
times already. (ide-scsi) Disabled automounter, did not use the changer, 
but when reading a bad audioCD with CDRW player, another lock up.

P.P.S. This same hardware (with the exception of new Intel NIC and 
instead of AGP display adapter, now using PCI S3(this S3 has been 
running on a different linux machine with uptimes over 90 days, so I 
believe the card is ok)) has been running fine and stable in windows for 
almost a year now, so unless it has something to do with the Intel NIC 
card, I don't believe I have faulty HW.

