Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRLLTR4>; Wed, 12 Dec 2001 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRLLTRr>; Wed, 12 Dec 2001 14:17:47 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:16367 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281809AbRLLTRj>; Wed, 12 Dec 2001 14:17:39 -0500
Date: Wed, 12 Dec 2001 20:17:32 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <paulus@samba.org>, <dwmw2@infradead.org>,
        <emoenke@gwdg.de>, <jhartmann@precisioninsight.com>,
        Vineet M Abraham <vmabraham@hotmail.com>,
        Dag Brattli <dag@brattli.net>, <mid@auk.cx>, <jochen@scram.de>,
        <becker@scyld.com>, <elmer@ylenurme.ee>, <ajk@iehk.rwth-aachen.de>
Subject: Re: Some compiler warnings in 2.4.17-pre5
In-Reply-To: <E16Cfnh-00019h-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.43.0112122015010.1213-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Alan Cox wrote:

> > +#ifdef MODULE
> >  static Scsi_Host_Template driver_template = IPH5526_SCSI_FC;
> > +#endif /* MODULE  */
>
> The ifdefs are frequently uglier than the warning 8). The i820 one looks
> most suspicious however.


It's perhaps a better solution to move driver_template inside the
#ifdef MODULE piece of code where it's used (I see that this was done in
some other places in 2.4.17-pre2 by David S. Miller):


--- drivers/net/fc/iph5526.c.old	Wed Dec 12 20:11:44 2001
+++ drivers/net/fc/iph5526.c	Wed Dec 12 20:13:34 2001
@@ -224,8 +224,6 @@
 static int get_scsi_oxid(struct fc_info *fi);
 static void update_scsi_oxid(struct fc_info *fi);

-static Scsi_Host_Template driver_template = IPH5526_SCSI_FC;
-
 static void iph5526_timeout(struct net_device *dev);

 static int iph5526_probe_pci(struct net_device *dev);
@@ -4529,6 +4527,7 @@
 static int irq;
 static int bad;	/* 0xbad = bad sig or no reset ack */
 static int scsi_registered;
+static Scsi_Host_Template driver_template = IPH5526_SCSI_FC;


 int init_module(void)

> Alan

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400


