Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315814AbSENQ1V>; Tue, 14 May 2002 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315815AbSENQ1U>; Tue, 14 May 2002 12:27:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58630 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315814AbSENQ1S>; Tue, 14 May 2002 12:27:18 -0400
Subject: Re: [PATCH] 2.5.15 IDE 61
To: nconway.list@ukaea.org.uk (Neil Conway)
Date: Tue, 14 May 2002 17:46:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CE1356A.B09C62F1@ukaea.org.uk> from "Neil Conway" at May 14, 2002 05:03:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177fRS-0008Hq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> block-layer because another request has been added, it needs to know
> that it shouldn't do anything until the DMAing finishes.  It could find
> that out by looking at a channel->busy flag.  If it doesn't use a busy
> flag, then what provides the locking?

You can either use device status information or the queue lock. It might
well be using channel->busy or queue->channel->busy type flags. However
you've now got a single queue and a single channel lock flowing through
a single function - which seems cleaner to me than splitting stuff into
multiple queues, locking them against one another and the like

> > From an abstract hardware point of view each ide controller is a queue not
> > each device. Not following that is I think the cause of much of the existing
> > pain and suffering.
> 
> Agreed.  And in the case of a cmd640 (etc.), the queue should handle
> both channels.

Yep
