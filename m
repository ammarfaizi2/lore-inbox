Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289120AbSBDRaC>; Mon, 4 Feb 2002 12:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289124AbSBDR3w>; Mon, 4 Feb 2002 12:29:52 -0500
Received: from sproxy.gmx.net ([213.165.64.20]:47305 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289120AbSBDR3g>;
	Mon, 4 Feb 2002 12:29:36 -0500
Message-ID: <3C5EC4E4.B5A6E84F@gmx.net>
Date: Mon, 04 Feb 2002 18:29:08 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, jdthood@yahoo.co.uk
Subject: Re: modular floppy broken in 2.5.3
In-Reply-To: <E16XU69-0005MJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > It turns out this is due to the new PnPBIOS kernel config option:
> >
> > [asuardi@dolphin asuardi]$ grep PnPBIOS /proc/ioports
> > 03f0-03f1 : PnPBIOS PNP0c01
> > 0600-067f : PnPBIOS PNP0c01
> > 0680-06ff : PnPBIOS PNP0c01
> >   0800-083f : PnPBIOS PNP0c01
> >   0840-084f : PnPBIOS PNP0c01
> > 0880-088f : PnPBIOS PNP0c01
> > f400-f4fe : PnPBIOS PNP0c01
> >
> > But since modular floppy was working before without setting any
> >  ioport parameter I'm not entirely sure this is a "feature".
>
> Its a mix of fp and pnpbios things that need untangling. PnPBIOS should
> register the resource as not in use, floppy should allocate the right

PNPNIOS is right to reserve PNP0C01 as "used". Else there will be hangs
when drivers poke in io space (e.g. laptops tend to have special
hardware which doesn't like to be touched).

PNPBIOS should not reserve 3f0/3f1 as a _workaround_ for this BIOS bug.

The BIOS probably wants to tell you there is a superio chip at 0x3f0
(try http://home.t-online.de/home/gunther.mayer/lssuperio-0.63.tar.gz).



