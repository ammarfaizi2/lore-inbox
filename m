Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbTJUOfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTJUOfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 10:35:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41711 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263121AbTJUOfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 10:35:03 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Tue, 21 Oct 2003 16:39:28 +0200
User-Agent: KMail/1.5.4
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310162020.51303.bzolnier@elka.pw.edu.pl> <20031021063536.GA78855@sgi.com>
In-Reply-To: <20031021063536.GA78855@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310211639.28346.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 of October 2003 08:35, Jeremy Higdon wrote:
> > - defining IDE_ARCH_ACK_INTR and ide_ack_intr() in sgiioc4.c is a no-op,
> >   it should be done <asm/ide.h> to make it work
> >   (I think the same problem is present in 2.4.x)
>
> The definition in <include/linux/ide.h> is only used if IDE_ARCH_ACK_INTR
> is not defined.  sgiioc4.c defines IDE_ARCH_ACK_INTR before including that
> file, so I believe we get the definition we want without touching ide.h,
> don't we?

ide_ack_intr() is used by ide-io.c.  If IDE_ARCH_ACK_INTR is not defined
in ide.h (and it won't be cause you are doing this only in sgiioc4.c
/sgiioc4.h in 2.4.x case/ about which ide-io.c has abolutely no idea)
ide_ack_intr() will turn into no-op and hwif->ack_intr() won't be called.

> I'll await a response on the IDE_ARCH_ACK_INTR issue.  Do you want me to
> send another patch, or is the previous with your update sufficient?

It is sufficient.

thanks,
--bartlomiej

