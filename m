Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTHPAek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 20:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272505AbTHPAek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 20:34:40 -0400
Received: from mta5.mail.adelphia.net ([64.8.50.187]:40069 "EHLO
	mta5.adelphia.net") by vger.kernel.org with ESMTP id S272503AbTHPAei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 20:34:38 -0400
Message-ID: <000a01c3638e$2c7a6330$6401a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: <herbert@13thfloor.at>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030813061546.GB24994@gamma.logic.tuwien.ac.at> <00ac01c36193$72c892a0$6401a8c0@wa1hco> <20030813123010.GA7274@www.13thfloor.at> <00bb01c36198$51cba650$6401a8c0@wa1hco> <20030813132429.GA7551@www.13thfloor.at> <009b01c362d5$13838b90$6401a8c0@wa1hco> <20030815030013.GA9587@www.13thfloor.at> <00a401c3632a$80dd2a20$6401a8c0@wa1hco> <20030815132619.GB3695@www.13thfloor.at>
Subject: 2.6.0-test3 _still_ cannot mount root fs
Date: Fri, 15 Aug 2003 20:34:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redhat's 2.4.20 will boot with root=/dev/hda3 pointing to an ext3
filesystem, without an initrd, with the following message

   ext2fs warning (device IDE0(3,3) )  ext2_read_super: mounting ext3
filesystem as ext2
   VFS: mounted root (ext2 filesystem) readonly

So I assumed that 2.6.0-test3 will also work with ext3 compiled as a module.
I tried the various suggestions root=/dev/hda3, root=0303, root=03:03
without any luck.

I then tested a suggestion that ext3 should get compiled in but get the same
results

> > > ============================================
> > > Case 2: grub, no initrd, kernel=/vmlinux-2.6.0-test3 ro root=/dev/hda3
> > >
> > > ...stuff scrolled off the screen...
> > > check >hda3<
> > > check <hda3< (<31)
> > > try_name() I
> > > try_name() >hda3<,0
> > > open > /dys/block/hda3/dev< = -1
> > > fail
> > > strtoul >3< -> 3
> > > try_name() II
> > > try_name hda < 3
> > > open >/sys/block/hda/dev< = 0
> > > read 0[32]=>3:0
> > > 5^(4)
> > > buf: >3:0<
> > > mkdev(3,0) -> 768
> > > open2 >/sys/block/hda/range< = 0
> > > read2 0[32] => 764
> > > < (3)
> > > buf: >64<
> > > strtoul >64< -> 64
> > > name to dev_t() done
> > > VFS: cannot open root dev "hda3" or hda3

Herbert's debug patch produced the same messages with ext3 compiled in.

Any suggestions for what to try next?

jeff

