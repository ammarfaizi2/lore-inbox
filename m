Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292894AbSB0V3O>; Wed, 27 Feb 2002 16:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292967AbSB0V2k>; Wed, 27 Feb 2002 16:28:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292968AbSB0V2O>; Wed, 27 Feb 2002 16:28:14 -0500
Subject: Re: read_proc issue
To: val@nmt.edu (Val Henson)
Date: Wed, 27 Feb 2002 21:42:04 +0000 (GMT)
Cc: rddunlap@osdl.org (Randy.Dunlap), laurent@augias.org (Laurent),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020227140432.L20918@boardwalk> from "Val Henson" at Feb 27, 2002 02:04:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gBps-0005wa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've encountered this problem before, too.  What is the "One True Way"
> to do this cleanly?  In other words, if you want to do a calculation
> once every time someone runs "cat /proc/foo", what is the cleanest way
> to do that?  The solution we came up with was to check the file offset
> and only do the calculation if offset == 0, which seems pretty
> hackish.

Another approach is to do the calculation open and remember it in per
fd private data. You can recover that and free it on release. It could
even be a buffer holding the actual "content"
