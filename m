Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWGJP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWGJP0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWGJP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:26:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:27029 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964839AbWGJP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:26:37 -0400
X-IronPort-AV: i="4.06,225,1149490800"; 
   d="scan'208"; a="95701792:sNHT1744144675"
Message-ID: <44B2716A.3030009@intel.com>
Date: Mon, 10 Jul 2006 08:25:30 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org, linux.nics@intel.com
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
References: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>
In-Reply-To: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2006 15:26:25.0254 (UTC) FILETIME=[34CA6860:01C6A435]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> I'm trying to get Linux running on a Nokia IP130 box.
> 
> The 3x Intel i82551ER NICs doesn't work.
> 
> Apply this patch which just removes the error return path (and adds a
> little debug info):
> 
> ===============================================================
> --- drivers/net/e100.c.orig     2006-07-09 12:03:14.000000000 +0200
> +++ drivers/net/e100.c  2006-07-09 12:03:22.000000000 +0200
> @@ -756,8 +756,7 @@
>         * the sum of words should be 0xBABA */
>        checksum = le16_to_cpu(0xBABA - checksum);
>        if(checksum != nic->eeprom[nic->eeprom_wc - 1]) {
> -               DPRINTK(PROBE, ERR, "EEPROM corrupted\n");
> -               return -EAGAIN;
> +               DPRINTK(PROBE, ERR, "EEPROM corrupted (stored: %4.4x, 
> calc'ed: %
> 4.4x)\n", nic->eeprom[nic->eeprom_wc - 1], checksum);
>        }
> 
>        return 0;
> ===============================================================
> 
> And everything works!
> 
> I think I've heard about this bug before, but I don't know why it occurs.
> So the best I can do is the above (ignore failed EEPROM checksum test).

[removed scott feldman since he's not maintained e100 for a long time now]

Hi,


If you have received a motherboard or card with a broken EEPROM then your card 
is in a limbo state - it might work but results are unreliable and may cause 
your entire system to break (and even data corruption).

You should contact the hardware vendor and have the board replaced or upgraded 
with a proper EEPROM. Continuing to work with the corrupted EEPROM image that 
you have now can seriously hurt you later on.

Cheers,

Auke
