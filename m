Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHaLbC>; Sat, 31 Aug 2002 07:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSHaLbC>; Sat, 31 Aug 2002 07:31:02 -0400
Received: from kraid.nerim.net ([62.4.16.95]:44304 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S317366AbSHaLbB>;
	Sat, 31 Aug 2002 07:31:01 -0400
Message-ID: <3D70A909.8080105@inet6.fr>
Date: Sat, 31 Aug 2002 13:31:21 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMB browser
References: <3D709AB7.705@linkvest.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Eric Cuendet wrote:

> Hi,
> I want to develop a filesystem driver. It will be able to access SMB 
> shares without mountnig.
> I'll do a daemon that use libsmbclient from Samba 3.0 that do all the 
> dirty stuff (getting the available domains, authenticating, getting 
> files, etc...) and a device driver that will be a filesystem driver. 
> The driver should communicate with the daemon to ask him about shares, 
> machines, domains, etc...
>
> The idea is:
> - the daemon should be started by "/etc/init.d/browser start" at 
> beginning
> - The daemon loads the driver into the kernel
> - The daemon then mounts the filesystem on /smb using the filesystem 
> provided by the driver
> - The driver waits for file requests on /smb to serve them
> The hierarchy will be :
>
> /smb --|-- WG1  --|-- Machine1 --|-- Share1
>       |          |              |-- Share2
>       |          |-- Machine2 --|-- Share1
>       |                         |-- Share2
>       |                         |-- Share3
>             |
>       |-- WG2  --|-- Machine3 --|-- Share1
>       |-- DOM1 --|-- Machine4 --|-- etc...
>       |-- DOM2 --|-- Machine5
>
> Then the user access /smb/WG2/Machine38/Share12/Dir1/File2
> Cool, no?


I see some shortcomings :

How will you handle multiple users ?
Janice and Bob have accounts on the Linux client and both want to have 
access at the same time to their [Home] for example :
|-- DOM1 --|-- Machine4--|--[Home]

How will you handle users with multiple logins on a Domain/Machine ?

Maybe you'd be better starting with something like :

local_user_home_directory--|--smb--|--login--|--WGx/DOMy--|....

user's could provide something like a ".smbwalker.config"
with lines like
login_to_try    how_to_get_credential

local_user_home_directory--|--smb could be mounted by automount or 
mounted/umounted on first login/end of last session

LB

