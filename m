Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbRAPLNx>; Tue, 16 Jan 2001 06:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130406AbRAPLNn>; Tue, 16 Jan 2001 06:13:43 -0500
Received: from Cantor.suse.de ([194.112.123.193]:16913 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130237AbRAPLNh>;
	Tue, 16 Jan 2001 06:13:37 -0500
Date: Tue, 16 Jan 2001 12:13:23 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
Message-ID: <20010116121323.A31583@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 10:48:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 10:48:34AM +0100, Ingo Molnar wrote:
> this is a safe, very fast [ O(1) ] object-permission model. (it's a
> variation of a former idea of yours.) A process can pass object
> fingerprints and kernel pointers to other processes too - thus the other
> process can access the object too. Threads will 'naturally' share objects,
>...

Just setuid etc. doesn't work with that because access cannot be easily
revoked without disturbing other clients.

To handle that you would probably need a "relookup if needed" mechanism 
similar to what NFSv4 has, so that you can force other users to relookup
after you revoked a key. That complicates the use a lot though.

Also the model depends on good secure random numbers, which is questionable
in many environments (e.g. a diskless box where the random device effectively
gets no new input) 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
