Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbUAEQow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUAEQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:44:52 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:24239 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264944AbUAEQot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:44:49 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 17:47:45 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <20040105040337.GB6393@leto.cs.pocnet.net>
In-Reply-To: <20040105040337.GB6393@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051747.45039.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 05:03, Christophe Saout wrote:
> Hi again,
>
> here another experiment.
>
> I have started moving the code over to using the cbio mechanism. I
> have only touched ide-disk.c though, I'm not sure about ide-taskfile.c.

Patch looks nice but I wonder if it is worth doing
(this code should die ASAP).

> The modifications work here with and without multmode and with all kinds
> of bios. Haven't been able to test error conditions since I don't have
> broken hardware. ;-)

Hehe... you can try to break it ;-).

> I also didn't touch ide-taskfile.c which has most probably also been
> broken by the ide_map_buffer change. And I stumbled across the code

Yep.

> calling end_request with a null sector count, ide_end_request will then
> take hard_nr_sectors which will end the whole request even if only one
> bio was finished, huh? Am I missing something here?

No, it is used mainly to fail requests.

This hack should be later removed with care
(there is some strange comment about locking).

> And when is bio == NULL in ide_map_buffer? Where can this happen?

In taskfile code - special requests are not bio baked (taskfile ioctl).

--bart

