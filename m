Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278177AbRJRWY1>; Thu, 18 Oct 2001 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278181AbRJRWYR>; Thu, 18 Oct 2001 18:24:17 -0400
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:63646 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278177AbRJRWYA>; Thu, 18 Oct 2001 18:24:00 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Alvord <jalvo@mbay.net>
Cc: Patrick Mochel <mochelp@infinity.powertie.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 00:23:44 +0200
Message-Id: <20011018222344.7467@smtp.wanadoo.fr>
In-Reply-To: <pbiust45nr5rtsl7d8qlf6gu8p8er91gtj@4ax.com>
In-Reply-To: <pbiust45nr5rtsl7d8qlf6gu8p8er91gtj@4ax.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maybe each driver could pass back a value indicating
>
>1) all done
>2) N milliseconds more, please
>
>and you could keep calling until every driver says all done. The
>all-done drivers would ignore any new interrupts. The Not-Yet drivers
>could get the last few interrupts the need to complete. Of course
>there would need to be an overall timeout. That would leave most of
>the responsibility with the drivers... who know most of the true
>requirements.

Hrm... The interesting thing with this scheme is that it allows
you to first block your queue, then let other driver do the same
while your async IO completes, and then come back. Well... this
could be an option to step "2" of my earlier proposal.
This requires the device structure to keep track of which driver
still wants to be called. It would only go to step 3 once all
drivers have ack'ed step 2.

Ben.


