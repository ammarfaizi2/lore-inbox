Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSF1KRr>; Fri, 28 Jun 2002 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSF1KRq>; Fri, 28 Jun 2002 06:17:46 -0400
Received: from sys-209.inet6.fr ([62.210.110.209]:49796 "EHLO ns1.inet6.fr")
	by vger.kernel.org with ESMTP id <S317101AbSF1KRq>;
	Fri, 28 Jun 2002 06:17:46 -0400
Message-ID: <3D1C3856.3020000@inet6.fr>
Date: Fri, 28 Jun 2002 12:20:06 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org, martin@daleki.de
Subject: Re: [BUG] IDE error in (un)stable trees
References: <20020627212843.3439f49e.diegocg@teleline.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>I get this error message when I run hdparm -Y /dev/hda, And after this,
>I try to access some mounted partition:
>
>System is a cyrix 6x86MX 200Mhz with a Microstar 5146, wich has a Sis
>5513 ide chipset Kernel is a 2.4.19-rc1, but is reporducible in the last
>-ac tree. So I think it may be related to my IDE chipset.
>
>(NOTE: After the kernel prints the bug, in 2.4.19-rc1 and
>2.4.19-pre8-ac3 the drive starts again, but system doesn't seems to work
>with the mounted partition of the slept drive, 2.5 doesn't work neither
>starts the drive...)
>
>  
>

1/ SiS5571 is not in the lookup table used to find the chipset 
capabilities. That shouldn't pose problem as from what I could gather 
from the web this is a basic EIDE chipset (ATA16 support only) and every 
unknown chipset is configured as an ATA16 capable chipset.

2/ timings might be messed up because of the FSB used (75MHz instead of 
66MHz) on your configuration.

If you can, underclock your mainboard to 66MHz and see what happens. If 
it solves your problem, then dynamically computing timings from the FSB 
(in my TODO list but behind ATA133 support) will eventually solve your 
problem. Until then you could modify the timings by hand (I could 
provide you a patch for your specific configuration).

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 



