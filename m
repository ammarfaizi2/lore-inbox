Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAINyO>; Tue, 9 Jan 2001 08:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRAINxz>; Tue, 9 Jan 2001 08:53:55 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:8723 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130032AbRAINws>;
	Tue, 9 Jan 2001 08:52:48 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101090931.f099VOk277651@saturn.cs.uml.edu>
Subject: Re: `rmdir .` doesn't work in 2.4
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 9 Jan 2001 04:31:24 -0500 (EST)
Cc: andrea@suse.de (Andrea Arcangeli), mhaque@haque.net (Mohammad A. Haque),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101081537570.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 04:08:58 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> [...] If you really need to destroy the directory
> that happens to be your pwd - sorry, no reliable way to do that without
> interesting locking. On _any_ UNIX out there. 2.2 included. It will
> happily give you -ENOENT and refuse to perform the action above in
> case if some other process renames your pwd. Yes, for rmdir(".");

Well, this bites.

Locking guess: use a global read-write lock, with the "write" case
being deletion of "." and the "read" case being everything else.
You could have one lock per CPU, with the writer needing to grab all
of them in order. So removal of "." pays the cost.

If the standards gripe, well, rmdot() is a nice name.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
