Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEBSo4>; Thu, 2 May 2002 14:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315350AbSEBSoz>; Thu, 2 May 2002 14:44:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48143 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315338AbSEBSow>; Thu, 2 May 2002 14:44:52 -0400
Message-ID: <3CD17A6D.1040809@evision-ventures.com>
Date: Thu, 02 May 2002 19:42:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: arjanv@redhat.com, rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <3CD15CFA.1090208@evision-ventures.com>	<20020502132552.G8073@devserv.devel.redhat.com>	<3CD16F03.9090900@evision-ventures.com> <20020502.104817.06390889.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik David S. Miller napisa?:
>    From: Martin Dalecki <dalecki@evision-ventures.com>
>    Date: Thu, 02 May 2002 18:53:23 +0200
> 
>    And then think about the fact that they are able to even *patch*
>    running kernels. There is no way I can be convinced that the whole
>    versioning stuff is neccessary or a good design for any purpose.
> 
> Hint: they never changes their ABIs for drivers.  This is why
> they can't fix several large scale bugs in their OS.  When the
> fix would break every third party Solaris driver on the planet
> they simply don't do the fix until the next major relase of the
> OS.

Yes I know. But my main point is that they maintain the
whole module symbol and dependency data entierly in user space
and MODULEVERSION in the *linux kernel*, just simply isn't worth the
trouble. Similarly the whole Tainted not tained MODULE_AUTHOR
and so on information simply shouldn't me maintained
in precious kernel RAM space.

Information about module dependencies does get resolved at
the proper level: not centralized in a single one Makefile
alike repository but by an *.conf file placed alongside of it.
The module objects them-self look very much like a simple *stripped*
ELF shared objects and don't contain any hack-in of string arrays
in the .text segment just to provide data which can be trivially
reconstructed and maintained in user space. Module request handling for hot
pluggable devices for example is done entierly inside user
space and so on...

Version consistency get's handled at the proper level - namely
the file packaging. Once and not repeatedly during every time
a particular module get's loaded and so on... And then there is
simple late kernel binding. After all having a messed up /kernel
dir is not a single bit more dangerous then just having a
trashed vmlinuz file.

Overall even the fact aside that they have a much stronger policy
about releases, the overall design is much cleaner then on the
linux side of the world.

Gosh - the whole /devices file-system is an old hat for Solaris.

