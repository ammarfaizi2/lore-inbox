Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130867AbQKTAsZ>; Sun, 19 Nov 2000 19:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130865AbQKTAsF>; Sun, 19 Nov 2000 19:48:05 -0500
Received: from [213.8.184.106] ([213.8.184.106]:44804 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S130692AbQKTAr4>;
	Sun, 19 Nov 2000 19:47:56 -0500
Date: Mon, 20 Nov 2000 02:17:23 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: Taisuke Yamada <tai@imasy.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old
 BIOS
In-Reply-To: <Pine.LNX.4.10.10011191553360.21359-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0011200208520.934-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Andre Hedrick wrote:

> On Mon, 20 Nov 2000, Dan Aloni wrote:
> 
> > Well, I could patch it so it adds that one sector ;-) But that's not the
> > right way. The true number of sectors is 90069840, since 90069839 doesn't
> > divide by the number of *real* heads (6) and the number of recording zones
> > (15). So it needs fixing.
> 
> 15 == 16 if 0 == 1 in realm of counting numbers.
> 
> Also geometry is a lie to begin with, so what is one more lie on top of
> another?

These are real values, IBM: 

http://www.storage.ibm.com/hardsoft/diskdrdl/desk/ds75gxp.htm

Let's try to read from the 90069840th sector:

# dd if=/dev/hdc of=/dev/null bs=512 count=1 skip=90069839
1+0 records in
1+0 records out

Walla. ;-)

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
