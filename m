Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTAWSjB>; Thu, 23 Jan 2003 13:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTAWSjA>; Thu, 23 Jan 2003 13:39:00 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:25490 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267118AbTAWSi6>; Thu, 23 Jan 2003 13:38:58 -0500
Date: Thu, 23 Jan 2003 19:47:44 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x: ide: smart ioctl() doesnt work...
Message-ID: <20030123184744.GA1069@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holla,

It seems, that it isn't possible to enable the SMART
Automatic Offline Test anymore with 2.4.x (I tried
2.4.13 and 2.4.20).

And additionally: Enabling an already enabled Automatic
Offline Test with 2.4.x disables it.

Switching back to 2.2.20 I was able to re-enable it.

I tried this with different tools: ide-smart, smartsuite,
smartmontools and had a look at their sources, but they
all use the same ioctl():

__u8 args[4] = {WIN_SMART, 0xF8, SMART_AUTO_OFFLINE, 0};
ioctl(fd, HDIO_DRIVE_CMD, &args);

The ioctl() returns no error, but it doesn't do anything:

root@darkside:~# uname -a
Linux darkside 2.4.20 #1 Thu Dec 5 23:17:41 CET 2002 i686 unknown unknown GNU/Linux

root@darkside:~# ide-smart /dev/hdb | grep AutoOff
OffLineStatus=130 {Completed}, AutoOffLine=No, OffLineTimeout=0 minutes
root@darkside:~# ide-smart -1 /dev/hdb
root@darkside:~# ide-smart /dev/hdb | grep AutoOff
OffLineStatus=130 {Completed}, AutoOffLine=No, OffLineTimeout=0 minutes

and:

root@darkside:~# ide-smart /dev/hdc | grep AutoOff
OffLineStatus=130 {Completed}, AutoOffLine=Yes, OffLineTimeout=38 minutes
root@darkside:~# ide-smart -1 /dev/hdc
root@darkside:~# ide-smart /dev/hdc | grep AutoOff
OffLineStatus=130 {Completed}, AutoOffLine=No, OffLineTimeout=38 minutes

Booting 2.2.20 I'm able to enable AutoOffLine via ide-smart -1.


I searched through the archives but didnt find anything
matching this...

Is this a known problem?
Did the ioctl() change somehow?
Am I able to work around it on a currently running 2.4 system?

And btw... Am I able to change the OffLineTimeout value somehow?


PS: Please CC: me in replies, since I'm not on the list.


regards,
   Mario
-- 
Ho ho ho! I am Santa Claus of Borg. Nice assimilation all together!
