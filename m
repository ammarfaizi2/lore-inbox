Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVIGSLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVIGSLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVIGSLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:11:47 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:39440 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932128AbVIGSLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:11:46 -0400
Date: Wed, 7 Sep 2005 20:12:12 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       Lee Revell <rlrevell@joe-job.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Rumen Ivanov Zarev <rzarev@its.caltech.edu>
Subject: Re: [PATCH] PCI: Unhide SMBus on Compaq Evo N620c
Message-Id: <20050907201212.5ade5d6c.khali@linux-fr.org>
In-Reply-To: <d120d500050906160158912aaa@mail.gmail.com>
References: <200509062039.j86KdWMr014934@inky.its.caltech.edu>
	<1126046590.13159.9.camel@mindpipe>
	<d120d500050906160158912aaa@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry, Lee, Rumen, all,

> > Should unlikely() be used for cases where the conditional will be
> > true iff a specific piece of hardware is present?  Seems like we'd
> > always lose.
> 
> I would say that we should definitely not use [un]likely for code that
> is executed once during boot.

I think that the point of using unlikely in pci/quirks is more political
than technical. PCI quirks are only needed because some manufacturers
don't play fair on purpose or are simply too bad to write a proper BIOS
init sequence. This shouldn't slow down the boot process for owners of
decent hardware that do not need such quirks, or at least should it slow
it down as little as possible. So it's only fair that the worst slowdown
happens when the quirks-needing hardware is actually found.

This consideration left apart, each test looking for a specific piece of
hardware, considered individually, is more likely to fail than succeed
on a random machine, so anyway the use of unlikely makes sense. Whether
or not we think it is worth the additional code is a different matter (I
do, but I know not everybody does.)

Thanks,
-- 
Jean Delvare
