Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIHxY>; Tue, 9 Jan 2001 02:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAIHxO>; Tue, 9 Jan 2001 02:53:14 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:45812 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129267AbRAIHxM>; Tue, 9 Jan 2001 02:53:12 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 09 Jan 2001 08:52:59 +0100
In-Reply-To: Rik van Riel's message of "Mon, 8 Jan 2001 16:30:10 -0200 (BRDT)"
Message-ID: <qwwelydgo10.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Mon, 8 Jan 2001, Rik van Riel wrote:
> And when the bit changes again, the page can be evicted
> from memory just fine. In the mean time, the locked pages
> will also have undergone normal page aging and at unlock
> time we know whether to swap out the page or not.
>
> I agree that this scheme has a higher overhead than your
> idea, but it also seems to be a bit more flexible and
> simple.  Alternatively, we could just scan the wired_list
> once a minute and move the unwired pages to the active
> list.

At IPC_UNLOCK there is no reference to the pages locked by this
segment available. We could perhaps move the whole locked list to the
active list if we unlock any segment.

Second point: How do we handle out of swap? I do not think that we
should lock these pages but keep them in the active list.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
