Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUFJUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUFJUwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFJUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:52:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20097 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263024AbUFJUwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:52:40 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Thu, 10 Jun 2004 15:58:54 +0200
User-Agent: KMail/1.5.3
References: <ca9jj9$dr$1@sea.gmane.org> <200406101459.45750.bzolnier@elka.pw.edu.pl> <ca9nid$bnc$1@sea.gmane.org>
In-Reply-To: <ca9nid$bnc$1@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406101558.54240.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 15:26, Lars wrote:
> hi

Hi,

> thanks for answering!
>
> rc2 worked completely stable with c1 disconnect halt enabled and low
> cpu temp.
> rc3 has no C1 enabled after booting, so the cpu temp rises, but its
> stable.
> when enabling the c1 disconnect halt after this with something like
> "setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) |
> 0x10)))"
> (from
> http://www.tldp.org/HOWTO/Athlon-Powersaving-HOWTO/approaches.html#commandl
>ine) the cpu is getting cool again but the system locks up frequently.
> so it would be great to have the fixup re-enabled at boottime.
> maybe a switch to force the fixup on boards without c1 disconnect
> bios-settings would do it ?

We can't do that, some older boards hang if C1 disconnect is used.

However you can enable fixup and then C1 Halt Disconnect yourself. :-)

setpci -v -H1 -s 0:0.0 6C.L=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6C.L) & 0x9F01FF01)))

- to enable fixup first

setpci -v -H1 -s 0:0.0 6F=$(printf %x $((0x$(setpci -H1 -s 0:0.0 6F) | 0x10)))

- to enable C1 Halt Disconnect

[ this is untested as I don't have nForce2 board ]

> thanks,
> lars
>
> Bartlomiej Zolnierkiewicz wrote:
> > Do you get lockups with -rc3 and not with -rc2?

