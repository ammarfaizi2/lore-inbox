Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSGTH45>; Sat, 20 Jul 2002 03:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSGTH45>; Sat, 20 Jul 2002 03:56:57 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:42966 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S317395AbSGTH45>; Sat, 20 Jul 2002 03:56:57 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value
References: <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Sat, 20 Jul 2002 10:00:00 +0200
In-Reply-To: <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com> (Linus
 Torvalds's message of "Tue, 16 Jul 2002 18:23:18 -0700 (PDT)")
Message-ID: <8765zazv5r.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Yes, EAGAIN doesn't really work as a close return value, simply because
> _nobody_ expects that (and leaving the file descriptor open after a
> close() is definitely unexpected, ie people can very validly complain
> about buggy behaviour).

Returning an error and still doing the operation is slightly awkward.
Are there any other syscalls which do similar things?

Of course, a significant portion of TCP related code would leak
descriptors like hell if the behavior of close() ischanged (there are
quite a few protocols which do not avoid race conditions resulting in
ECONNRESET connection teardown).

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
