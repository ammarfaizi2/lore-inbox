Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbQL1WnB>; Thu, 28 Dec 2000 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbQL1Wmx>; Thu, 28 Dec 2000 17:42:53 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:21653 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131911AbQL1Wmn>; Thu, 28 Dec 2000 17:42:43 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: aeb@veritas.com (Andries Brouwer),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        gilbertd@treblig.org (Dave Gilbert)
Subject: Re: [Patch] shmmin behaviour back to 2.2 behaviour
In-Reply-To: <E14BfJ6-0003qw-00@the-village.bc.nu>
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3hf3ourke.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 28 Dec 2000 23:13:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> There are fundmental things shm* can do that mmap cannot. Does posix
> shm handle those (leaving segments alive but unattached being the
> obvious one)

Yes:
        shmget           == shm_open (+ ftruncate(fd, size))
        shmat            == mmap (0, size, , , fd, 0)
        shmdt            == munmap (addr, size);
        shmctl(IPC_RMID) == shm_unlink ()
        shmctl(IPC_STAT) == fstat();
        shmctl(IPC_LOCK) == mlock() /*nearly*/
        shmctl(IPC_SET)  == fchown(), fchmod()

You can get the Linux special behaviour to be able to attach to a
removed segment by its shmid by passing the file descriptor for the
posix shm from the attached process to the attaching process.

Did I miss something?
                        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
