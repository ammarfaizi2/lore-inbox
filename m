Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSA2Kj4>; Tue, 29 Jan 2002 05:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289482AbSA2Kjr>; Tue, 29 Jan 2002 05:39:47 -0500
Received: from david.siemens.de ([192.35.17.14]:17286 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S288302AbSA2Kjk>;
	Tue, 29 Jan 2002 05:39:40 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] KERN_INFO for devfs
Date: Tue, 29 Jan 2002 13:39:09 +0300
Message-ID: <000701c1a8b1$2f493850$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <200201290940.g0T9etE27352@Port.imtp.ilyichevsk.odessa.ua>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 29 January 2002 05:27, Borsenkow Andrej wrote:
> > > I changed "none" to "devfs" in do_mount("none", "/dev", "devfs",
0,
> >
> > ""):
> > > "none is busy" is misleading at umount time :-)
> >
> > File systems that do not have real devices behind them have "none"
as
> > device. Please do not change it - it was correct. Having it later in
> > /proc/mounts may confuse some user-level tools. If you want to fix
it -
> > fix umount to report something more sensible if device == none.
> 
> Why do you think they _have to_ have "none"? Is it POSIXized or
otherwise
> standardized? Where can I RTFM?

I do not think they have to. They just are :-)

fs/namespace.c:show_vfsmnt()

...
mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");


I find this convention quite useful. It allows any program to easily
skip virtual filesystems. Using something like /dev or devfs in this
case does not add any bit of useful information but possibly adds to
confusion.

-andrej

