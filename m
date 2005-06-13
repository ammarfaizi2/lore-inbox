Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVFMKnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVFMKnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVFMKnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:43:50 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:18448 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261464AbVFMKnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:43:47 -0400
Message-ID: <42AD6362.1000109@rainbow-software.org>
Date: Mon, 13 Jun 2005 12:43:46 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
In-Reply-To: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> Hi there,
> 
> A new 'old' box, with near 3:1 hdparm -Tt /dev/hda performance drop 
> comparing 2.4.31 with 2.6.11.12. pII/266 on 440LX chipset. HDD set 
> to udma2 (max for h/w) with manuf. utility.  Single master on ribbon.
> CDROM on other ribbon.  Two runs each via ssh login soon after boot:

I see this problem too with i430TX chipset (the south bridge and thus 
IDE controller is the same as in i440LX/EX and BX/ZX).

2.6.12-rc5:
/dev/hda:
  Timing cached reads:   180 MB in  2.02 seconds =  89.11 MB/sec
  Timing buffered disk reads:   40 MB in  3.09 seconds =  12.94 MB/sec

2.4.31:
/dev/hda:
  Timing cached reads:   180 MB in  2.03 seconds =  88.67 MB/sec
  Timing buffered disk reads:   62 MB in  3.01 seconds =  20.60 MB/sec

I also noticed that during the buffered read test on 2.6 kernel, the IDE 
activity LED is blinking (so the drive is not 100% utilised) while it's 
permanently on with 2.4.

> Linux 2.4.31-si.
> root@silly:~# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   344 MB in  1.99 seconds = 172.86 MB/sec
>  Timing buffered disk reads:   68 MB in  3.02 seconds =  22.52 MB/sec
> root@silly:~# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   356 MB in  2.00 seconds = 178.00 MB/sec
>  Timing buffered disk reads:   68 MB in  3.04 seconds =  22.37 MB/sec
> root@silly:~#
> 
> Linux 2.6.11.12a.
> root@silly:~# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   340 MB in  2.01 seconds = 168.76 MB/sec
>  Timing buffered disk reads:   26 MB in  3.02 seconds =   8.60 MB/sec
> root@silly:~# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   340 MB in  2.01 seconds = 169.26 MB/sec
>  Timing buffered disk reads:   26 MB in  3.02 seconds =   8.61 MB/sec
> root@silly:~#
> 
> Hardware info, configs, etc at http://scatter.mine.nu/test/boxen/silly/
> --Grant.
> 

-- 
Ondrej Zary
