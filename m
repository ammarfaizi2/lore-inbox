Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbQLZJ7w>; Tue, 26 Dec 2000 04:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131504AbQLZJ7m>; Tue, 26 Dec 2000 04:59:42 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:140 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131341AbQLZJ72>; Tue, 26 Dec 2000 04:59:28 -0500
To: Dave Gilbert <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat returning NULL with 0 sized segment
In-Reply-To: <Pine.LNX.4.10.10012250109450.666-100000@tardis.home.dave>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10012250109450.666-100000@tardis.home.dave>
Message-ID: <m3vgs8b9u5.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 26 Dec 2000 10:31:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Gilbert <gilbertd@treblig.org> writes:

>   I'm trying to debug a weird problem with Xine - its screwing up its use
> of shared memory for regions I haven't sussed yet.  One odd consequence is
> that it has apparently successfully managed to allocate a 0 byte chunk of
> shared memory; shmat is then called with shmaddr=0 and shmflg=0; the
> result of shmat is 0
> 
>   Is this what shmat is supposed to do in this (admittedly odd)
> circumstance? The error behaviour is defined in the man page as returning
> -1 on error.

Yes, this should be competely legal and wanted. Some programs use
shmget (..,0,..) to test if the segment is there. Apparently Xine does
this while setting the IPC_CREATE flag. This is legal on 2.4 (wasn't
in 2.2) and gives you a 0 byte segment.

shmat will give you then the legal address 0 like mmap would.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
