Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315854AbSEGPJq>; Tue, 7 May 2002 11:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSEGPJn>; Tue, 7 May 2002 11:09:43 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:6322 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315854AbSEGPJW>; Tue, 7 May 2002 11:09:22 -0400
Message-ID: <3CD7EDC4.3090508@antefacto.com>
Date: Tue, 07 May 2002 16:07:48 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <20020507160825.S22215@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, May 07, 2002 at 02:57:46PM +0100, Anton Altaparmakov wrote:
>  > How do I get this information with hdparm please?
>  > 
>  > [aia21@drop ide]$ cat via
> 
> Bartlomiej Zolnierkiewicz moved all this stuff to userspace
> a long time ago in 'ideinfo'.
> 
>  > [aia21@drop hda]$ cat cache
>  > 1916
>  > [aia21@drop hda]$ cat capacity
>  > 80418240
>  > [aia21@drop hda]$ cat geometry
>  > physical     79780/16/63
>  > logical      5005/255/63
>  > 
>  > And hdparm never gives you the physical geometry AFAICS.
> 
> Why would a normal user ever need to know this info?

Well one application we have here is a backup script in a web
interface (php running as nobody), which copies a whole disk
(compact flash) to the client while indicating the total size
to the client for feedback:

Header("Content-type: application/octet-stream");
$flash_size=`cat /proc/ide/hda/capacity`;
$flash_size=$flash_size*512;
Header("Content-length: $flash_size");
Header("Content-Disposition: attachment; filename=flash.img");
passthru("/bin/suid_copy_flash");

Now you could of course have a /bin/suid_get_flash_size
but this is messy/less efficient?

Padraig.

