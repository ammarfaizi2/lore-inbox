Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266900AbRGMO6o>; Fri, 13 Jul 2001 10:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267486AbRGMO6f>; Fri, 13 Jul 2001 10:58:35 -0400
Received: from weta.f00f.org ([203.167.249.89]:9347 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266900AbRGMO6V>;
	Fri, 13 Jul 2001 10:58:21 -0400
Date: Sat, 14 Jul 2001 02:19:19 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Harvey <daniel@amristar.com.au>
Cc: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Message-ID: <20010714021919.A5058@weta.f00f.org>
In-Reply-To: <NEBBJDBLILDEDGICHAGAOEAGCGAA.daniel@amristar.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NEBBJDBLILDEDGICHAGAOEAGCGAA.daniel@amristar.com.au>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 01:57:17PM +0800, Daniel Harvey wrote:

     BIOS-e820: 0000000000000000 - 000000000009f800 (usable)

0 -> 638K

     BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)

638K -> 640K

        presumably you loose 2k at the top because the bios is doing
        something with it

     BIOS-e820: 00000000000ea000 - 0000000000100000 (reserved)

936K -> 1024K / 1M

        more reserved stuff

     BIOS-e820: 0000000000100000 - 000000000fbf0000 (usable)

1M -> ~ 251M (256M less 4160K)

     BIOS-e820: 000000000fbf0000 - 000000000fbffc00 (ACPI data)
     BIOS-e820: 000000000fbffc00 - 000000000fc00000 (ACPI NVS)

ACPI stuff

     BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)

4G - 128M -> 4G


I'm not sure where above the video memory resides, probably in the
last usable section looking at the size of it, but I don't see why it
should be marked as usable then.  Also, if it was being misreported, I
would expect running X and such like to clobber kernel buffers
eventually and cause all sorts of nasties (like disk corruption).

Was does lspci -v report for the video (VGA Adapters) address? You
might also be able to find this from the XF86 startup session.

Also, can you try adding a line like:

        mempages >>= 1;

to the start of fs/dcache.c:dcache_init(...) after the variable
delcaration obviously and see if that helps at all?





  --cw
