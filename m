Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSIALm6>; Sun, 1 Sep 2002 07:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSIALm5>; Sun, 1 Sep 2002 07:42:57 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:2188 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316705AbSIALm4>; Sun, 1 Sep 2002 07:42:56 -0400
Subject: Re: SMB browser
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D709AB7.705@linkvest.com>
References: <3D709AB7.705@linkvest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 14:47:47 +0300
Message-Id: <1030880868.31922.44.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 13:30, Jean-Eric Cuendet wrote:
> Hi,
> I want to develop a filesystem driver. It will be able to access SMB 
> shares without mountnig.
> I'll do a daemon that use libsmbclient from Samba 3.0 that do all the 
> dirty stuff (getting the available domains, authenticating, getting 
> files, etc...) and a device driver that will be a filesystem driver. The 
> driver should communicate with the daemon to ask him about shares, 
> machines, domains, etc...

People who reinvent the wheel usually end up making it square. 


> 
> The idea is:
> - the daemon should be started by "/etc/init.d/browser start" at beginning
> - The daemon loads the driver into the kernel
> - The daemon then mounts the filesystem on /smb using the filesystem 
> provided by the driver
> - The driver waits for file requests on /smb to serve them
> The hierarchy will be :
> 
> /smb --|-- WG1  --|-- Machine1 --|-- Share1
>        |          |              |-- Share2
>        |          |-- Machine2 --|-- Share1
>        |                         |-- Share2
>        |                         |-- Share3
>              |
>        |-- WG2  --|-- Machine3 --|-- Share1
>        |-- DOM1 --|-- Machine4 --|-- etc...
>        |-- DOM2 --|-- Machine5
> 
> Then the user access /smb/WG2/Machine38/Share12/Dir1/File2
> Cool, no?
> 
> The authentication is done externally from the kernel, by a userland 
> process or PAM (a kerberos ticket is gotten from the Domain controller 
> or Samba PDC). Then the daemon uses that info to authenticate in the 
> domain. If no auth info is available, then it's authenticated as Guest.
> 
> My question:
> what is the best/easy way to make a kernel driver communicate with 
> userland? Is it via UNIX socket? Or ioctl? Shared memory? Else?
> 
> Thanks for any idea.
> -jec
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

