Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTHJXCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHJXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:00:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23504 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270800AbTHJXAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:00:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jan Niehusmann <jan@gondor.com>
Subject: Re: uncorrectable ext2 errors
Date: Mon, 11 Aug 2003 01:01:16 +0200
User-Agent: KMail/1.5
References: <20030806150335.GA5430@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl> <20030810213450.GA7050@gondor.com>
In-Reply-To: <20030810213450.GA7050@gondor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110101.16795.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 of August 2003 23:34, Jan Niehusmann wrote:
> On Sun, Aug 10, 2003 at 11:19:55PM +0200, Andries Brouwer wrote:
> > I see no kernel version in your post, that would be the first thing
> > of interest. Next, look at this addressing variable via /proc.
>
> Sorry - I mentioned it in an earlier post with a different subject. It's
> plain 2.4.21.
>
> > It it is zero, then you are hit by something avoided by the patch
> > I sketched yesterday evening or so. Otherwise we must look further.
>
> It is 0, yes. May it be caused by the following lines in pdc202xx_old.c?
>
>         if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
>                 hwif->addressing = (hwif->channel) ? 0 : 1;

Yes.  I did some googling.

http://www.ussg.iu.edu/hypermail/linux/kernel/0209.0/0000.html
and
http://www.ussg.iu.edu/hypermail/linux/kernel/0209.0/0898.html

are essential.

It looks LBA-48 was disabled on PDC20265 as a "workaround", because there
was a stupid in Promise LBA-48 support.
Bug was fixed, but "workaround" disabling LBA-48 was never removed.

You can remove these two lines and see if it helps
(but it may corrupt your fs even more if it doesn't).

Because of this bug you are hitting another bug which Andries has described
recently.

--bartlomiej

