Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbRGZP2f>; Thu, 26 Jul 2001 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbRGZP20>; Thu, 26 Jul 2001 11:28:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267484AbRGZP2P>; Thu, 26 Jul 2001 11:28:15 -0400
Subject: Re: ext3-2.4-0.9.4
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 26 Jul 2001 16:28:49 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org (lkml),
        ext3-users@redhat.com (ext3-users@redhat.com)
In-Reply-To: <20010726164516.R17244@emma1.emma.line.org> from "Matthias Andree" at Jul 26, 2001 04:45:16 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Pn4D-0003vy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> them, and MTAs are portable, they choose chattr +S on Linux. And that's
> a performance problem because it doesn't come for free, but also with
> synchronous data updates, which are unnecessary because there is
> fsync().

chattr +S and atomic updates hitting disk then returning to the app will
give the same performance. You can also fsync() the directory. 

> the "my rename call has returned 0" event. They expect that with the
> call returning the rename operation has completed ultimately, finally,
> for good, definitely and the old file will not reappear after a crash.

Actually the old file re-appearing after the crash is irrelevant. It will
have a previously logged message id. And if you are not doing message id
histories then you have replay races at the SMTP level anyway

> This still implies the drive doesn't lie to the OS about the completion
> of write requests: write cache == off.

Write cache off is not a feature available on many modern disks. You
already lost the battle before you started.

Alan
