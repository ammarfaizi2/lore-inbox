Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310641AbSCHBqg>; Thu, 7 Mar 2002 20:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310640AbSCHBq1>; Thu, 7 Mar 2002 20:46:27 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:15608 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S310641AbSCHBqO>; Thu, 7 Mar 2002 20:46:14 -0500
Message-ID: <00b901c1c642$e7b6e9b0$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <014701c1c5b6$a0dfb620$59cca8c0@hank> <3C873F96.C91E3591@redhat.com>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Fri, 8 Mar 2002 09:45:15 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

    That's because the linux-kernel misunderstand the raid controller
to IDE controller. If do so, The raid driver will be unstable when
be loaded.

    So we must to prevent the raio controller to be as IDE controller
here.

Regards
Hank Yang.

----- Original Message -----
From: "Arjan van de Ven" <arjanv@redhat.com>
To: "Hank Yang" <hanky@promise.com.tw>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 07, 2002 6:23 PM
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch


>
> >   {DEVID_PDC20268,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX,
INIT_PDC202XX,
> > NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
> > - /* Promise used a different PCI ident for the raid card apparently to
try
> > and
> > -    prevent Linux detecting it and using our own raid code. We want to
> > detect
> > -    it for the ataraid drivers, so we have to list both here.. */
> > - {DEVID_PDC20268R,"PDC20268", PCI_PDC202XX, ATA66_PDC202XX,
INIT_PDC202XX,
> > NULL,  {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 16 },
>
>
> Interesting. So you remove support for the raid drivers. Why ?
>
> More places where you do this:
>
> > @@ -774,7 +784,8 @@
> >        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265) ||
> >        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20267) ||
> >        IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268) ||
> > -      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
> > +      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
> > +      IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
> >        IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
> >        IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
>
> > diff -urN linux-2.4.18.org/include/linux/pci_ids.h
> > linux/include/linux/pci_ids.h
> > --- linux-2.4.18.org/include/linux/pci_ids.h Tue Feb 26 03:38:13 2002
> > +++ linux/include/linux/pci_ids.h Wed Feb 27 19:45:18 2002
> > @@ -603,7 +603,6 @@
> >  #define PCI_DEVICE_ID_PROMISE_20246 0x4d33
> >  #define PCI_DEVICE_ID_PROMISE_20262 0x4d38
> >  #define PCI_DEVICE_ID_PROMISE_20268 0x4d68
> > -#define PCI_DEVICE_ID_PROMISE_20268R 0x6268
> >  #define PCI_DEVICE_ID_PROMISE_20269 0x4d69
> >  #define PCI_DEVICE_ID_PROMISE_20275 0x1275
> >  #define PCI_DEVICE_ID_PROMISE_5300 0x5300
> .org/lkml/

