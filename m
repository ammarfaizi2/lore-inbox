Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131921AbRASRx0>; Fri, 19 Jan 2001 12:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRASRxR>; Fri, 19 Jan 2001 12:53:17 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56078 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131921AbRASRxG>;
	Fri, 19 Jan 2001 12:53:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101191752.UAA24169@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 19 Jan 2001 20:52:53 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010118220428.G28276@athlon.random> from "Andrea Arcangeli" at Jan 18, 1 10:04:28 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I thought setsockopt is meant to set an option in the socket,

It is not.

setsockopt() is simply a bit more clever extension to ioctl(),
which is adapted (in bsd style though) to understand layering
and has an explicit length to data.

It is prefered for all the operations on sockets,
and it is "must", if argument is not plain integer or operation
is specific to some protocol layer.


> controls the I/O (aka ioctl ;). Anyways either ioctl or setsockopt is fine in
> pratice

After BKL is moved down.



> NAGLE algorithm is only one, CORK algorithm is another different algorithm.

It is one algorithm. They differ only by amount of incomplete segments
allowed to be in flight. I.e. (in order of increased latency):

"nodelay" - Infinity
unnamed   - > 1
"nagle"   - 1
"cork"    - 0


Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
