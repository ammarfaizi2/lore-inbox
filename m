Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRJDKxH>; Thu, 4 Oct 2001 06:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273385AbRJDKw6>; Thu, 4 Oct 2001 06:52:58 -0400
Received: from janeway.cistron.net ([195.64.65.23]:24837 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S273360AbRJDKwj>; Thu, 4 Oct 2001 06:52:39 -0400
Date: Thu, 4 Oct 2001 12:53:06 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011004125306.A10138@cistron.nl>
Mail-Followup-To: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110031901.TAA04080@vlet.cwi.nl> <20011004013950.A16757@cistron.nl> <20011003211508.O8954@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011003211508.O8954@turbolinux.com>; from adilger@turbolabs.com on Wed, Oct 03, 2001 at 09:15:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andreas Dilger wrote:
> If you already have data on the PV in
> question, you can "dd if=/dev/zero of=/dev/sdb bs=1 seek=510 count=2"
> to remove only the partition signature.

That helped and the kernel no longer sees that partition anymore.
However LVM still doesn't work:

cloud:/dev/discs/disc1# vgscan
vgscan -- reading all physical volumes (this may take a while...)
vgscan -- found active volume group "vg_user"
vgscan -- "/etc/lvmtab" and "/etc/lvmtab.d" successfully created
vgscan -- WARNING: This program does not do a VGDA backup of your volume group

cloud:/dev/discs/disc1# vgchange -a y
vgchange -- ERROR: VGDA in kernel and lvmtab are NOT consistent; please run vgscan

I did a bit of looking around and it seems the confusement is in the
kernel: when lvm_check_kernel_lvmtab_consistency() compares the kernel
and the lvmtab entries the list from the kernel mentions the vg_user
volume group twice, while the lvmtab only mentions it once.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
