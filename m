Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUL2Wic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUL2Wic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUL2Wic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:38:32 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:1007 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261270AbUL2Wi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:38:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=swR5V7GU0rC1pg+WpLpMBveOtusLvzVqRazsmMsJPO4M0i7AmyuEnzPTOspFxeXzNlVQoi7JcnSffTOUHC5tXs9csC44niiaQiiQAccI1oNTDnn4XdMknrvw4yqWN3XCmE8kpTXjvovzgt387XqUMtZd0ggwT0vSS4mfB683PTs=
Message-ID: <58cb370e04122914384fba1973@mail.gmail.com>
Date: Wed, 29 Dec 2004 23:38:27 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <1104355483.31622.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
	 <1104355483.31622.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 21:24:45 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> > ide_get_best_pio_mode(drive, 4, 5, NULL) always returns 4
> > [ quick fix == hardcode 4 for now and add FIXME ]
> 
> Doesn't seem that way reading the code.

u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8
max_mode, ide_pio_data_t *d)
{

/* mode_wanted == 4, max_mode == 5 */

...

	if (mode_wanted != 255) {

/* 4 != 255 */

		pio_mode = mode_wanted;

/* pio_mode == 4 */

	} else if (!drive->id) {
		pio_mode = 0;
	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
		overridden = 1;
		blacklisted = 1;
		use_iordy = (pio_mode > 2);
	} else {
...
	}
...
	return pio_mode;
}
