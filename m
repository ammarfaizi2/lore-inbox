Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282175AbRK1Xjn>; Wed, 28 Nov 2001 18:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282197AbRK1Xje>; Wed, 28 Nov 2001 18:39:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2322 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282192AbRK1XjT>; Wed, 28 Nov 2001 18:39:19 -0500
Subject: Re: sym53c875: reading /proc causes SCSI parity error
To: davem@redhat.com (David S. Miller)
Date: Wed, 28 Nov 2001 23:47:45 +0000 (GMT)
Cc: groudier@free.fr, matthias@winterdrache.de, linux-kernel@vger.kernel.org
In-Reply-To: <20011128.131503.22504634.davem@redhat.com> from "David S. Miller" at Nov 28, 2001 01:15:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169EQb-0006WK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not just put some bitmap pointer into the pci device
> struct.  If it is non-NULL, it specifies PCI config space
> areas which have side-effects.

Why not avoid poking around in dangerous device spaces. We don't have a
bitmap to protect /dev/mem either. The problem is similar too, we have many
devices with config space beyond the guaranteed bytes that do fatal
things that are not driven directly by Linux - eg some bridges have acpi
stuff overlapping there.

A non root user can only touch the safe bytes
