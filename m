Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292000AbSBOAQW>; Thu, 14 Feb 2002 19:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292020AbSBOAQN>; Thu, 14 Feb 2002 19:16:13 -0500
Received: from rgminet1.oracle.com ([148.87.122.30]:51922 "EHLO
	rgminet1.oracle.com") by vger.kernel.org with ESMTP
	id <S292000AbSBOAP7>; Thu, 14 Feb 2002 19:15:59 -0500
Message-ID: <3C6C5390.6010603@oracle.com>
Date: Fri, 15 Feb 2002 01:17:20 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [upatch] Re: linux-2.5.5-pre1
In-Reply-To: <20020214083050.GF1598@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> [Alessandro Suardi]
> 
>>  More issues:
>>
>>    - xconfig broken
>>
> 
> Untested but obvious..
> 
> --- 2.5.5pre1/sound/Config.in~	Wed Feb 13 20:57:11 2002
> +++ 2.5.5pre1/sound/Config.in	Thu Feb 14 02:26:21 2002
> @@ -19,13 +19,13 @@
>    source sound/core/Config.in
>    source sound/drivers/Config.in
>  fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" == "y" ]; then
> +if [ "$CONFIG_SND" != "n" -a "$CONFIG_ISA" = "y" ]; then
>    source sound/isa/Config.in
>  fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" == "y" ]; then
> +if [ "$CONFIG_SND" != "n" -a "$CONFIG_PCI" = "y" ]; then
>    source sound/pci/Config.in
>  fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" == "y" ]; then
> +if [ "$CONFIG_SND" != "n" -a "$CONFIG_PPC" = "y" ]; then
>    source sound/ppc/Config.in
>  fi

Good - but not enough :)

[asuardi@dolphin linux]$ make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
/usr/src/linux/include
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.5.5-pre1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/isa/Config.in: 23: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.5-pre1/scripts'
make: *** [xconfig] Error 2

It looks like adding $CONFIG_SND on line 23 in sound/isa/Config.in
  makes xconfig start up...


Thanks,
--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

