Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHaKac>; Sat, 31 Aug 2002 06:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSHaKac>; Sat, 31 Aug 2002 06:30:32 -0400
Received: from mta12n.bluewin.ch ([195.186.4.221]:24979 "EHLO
	mta12n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S317063AbSHaKab>; Sat, 31 Aug 2002 06:30:31 -0400
Message-ID: <3D709AB7.705@linkvest.com>
Date: Sat, 31 Aug 2002 12:30:15 +0200
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Subject: SMB browser
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I want to develop a filesystem driver. It will be able to access SMB 
shares without mountnig.
I'll do a daemon that use libsmbclient from Samba 3.0 that do all the 
dirty stuff (getting the available domains, authenticating, getting 
files, etc...) and a device driver that will be a filesystem driver. The 
driver should communicate with the daemon to ask him about shares, 
machines, domains, etc...

The idea is:
- the daemon should be started by "/etc/init.d/browser start" at beginning
- The daemon loads the driver into the kernel
- The daemon then mounts the filesystem on /smb using the filesystem 
provided by the driver
- The driver waits for file requests on /smb to serve them
The hierarchy will be :

/smb --|-- WG1  --|-- Machine1 --|-- Share1
       |          |              |-- Share2
       |          |-- Machine2 --|-- Share1
       |                         |-- Share2
       |                         |-- Share3
             |
       |-- WG2  --|-- Machine3 --|-- Share1
       |-- DOM1 --|-- Machine4 --|-- etc...
       |-- DOM2 --|-- Machine5

Then the user access /smb/WG2/Machine38/Share12/Dir1/File2
Cool, no?

The authentication is done externally from the kernel, by a userland 
process or PAM (a kerberos ticket is gotten from the Domain controller 
or Samba PDC). Then the daemon uses that info to authenticate in the 
domain. If no auth info is available, then it's authenticated as Guest.

My question:
what is the best/easy way to make a kernel driver communicate with 
userland? Is it via UNIX socket? Or ioctl? Shared memory? Else?

Thanks for any idea.
-jec



