Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbTCGUJI>; Fri, 7 Mar 2003 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbTCGUJI>; Fri, 7 Mar 2003 15:09:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:18817 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261731AbTCGUJD>;
	Fri, 7 Mar 2003 15:09:03 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Mar 2003 21:19:33 +0100 (MET)
Message-Id: <UTC200303072019.h27KJXX12872.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, patmans@us.ibm.com
Subject: Re: [PATCH] scsi_error fix
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Patrick Mansfield <patmans@us.ibm.com>

    > [Further discussion and things I did not yet investigate:
    > What was changed to make this fail first in 2.5.63?
    > Experience shows that we get into a loop when something else
    > than SUCCESS is returned here. Probably that is a bug elsewhere.
    > Probably the commands that cause problems should never have been
    > sent in the first place.]

    The scsi error handler is also used to retrieve sense data for
    adapters/drivers that do not auto retrieve it. In such cases, it should
    not issue any aborts, resets etc.

Indeed.

    Your change effectively disables that support - we never hit the code in
    scsi_eh_get_sense() to request sense. It would be very nice if we could
    fix (or audit) all the scsi drivers, apply your change and remove
    scsi_eh_get_sense, but AFAIK that has not and is not happening.

No. What happened before was that we got into an infinite loop.
The right action is to read the code, understand why it gets
into a loop, and fix it. Once that has happened we may decide
to undo my change. Or we may decide to ask for sense at that very spot.

Today both James and Mike say that they can reproduce the loop,
so probably they'll fix that part. If not, I'll have a look again.

Andries
