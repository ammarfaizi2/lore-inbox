Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270466AbRHSOFu>; Sun, 19 Aug 2001 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270467AbRHSOFj>; Sun, 19 Aug 2001 10:05:39 -0400
Received: from fedex.is.co.za ([196.4.160.243]:46864 "EHLO fedex.is.co.za")
	by vger.kernel.org with ESMTP id <S270464AbRHSOFe>;
	Sun, 19 Aug 2001 10:05:34 -0400
Date: Sun, 19 Aug 2001 16:06:05 +0200
From: Dewet Diener <linux-kernel@dewet.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3 partition unmountable
Message-ID: <20010819160605.A9890@darkwing.flatlit.net>
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net> <3B7EEC4C.D0127AB4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7EEC4C.D0127AB4@zip.com.au>; from akpm@zip.com.au on Sat, Aug 18, 2001 at 03:29:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 03:29:32PM -0700, Andrew Morton wrote:
> Somehow you seem to have set bit 16, which isn't defined.  Not sure how
> to fix this without simply running a binary editor against /dev/hdd1 and
> clearing the byte at offset 0x462.

Hi Andrew

I managed to fix it by running e2fsck off one of the backup 
superblocks - that seems to have repaired the broken bits:

000400 cc 5b 0e 00 de ab 1c 00 ff 6e 01 00 35 da 13 00
000410 1f 36 0e 00 00 00 00 00 02 00 00 00 02 00 00 00
000420 00 80 00 00 00 80 00 00 60 3f 00 00 df 05 7f 3b
000430 df 05 7f 3b 16 00 14 00 53 ef 01 00 01 00 00 00
000440 60 05 7f 3b ed 4e ed 00 00 00 00 00 01 00 00 00
000450 00 00 00 00 0b 00 00 00 80 00 00 00 04 00 00 00
000460 06 00 00 00 01 00 00 00 e8 08 28 0e 57 e9 42 00
000470 ff 7d fe 3d ec af 84 ef 00 00 00 00 00 00 00 00
000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Then I just reran "tune2fs -j", and mounted it as ext3.  I hope that
was the correct approach, but its working in any case :)  Don't quite
know why/how the superblock got corrupted like that in the first
place :-/

Regards,
Dewet

