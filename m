Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEQUJ>; Tue, 5 Dec 2000 11:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEQUB>; Tue, 5 Dec 2000 11:20:01 -0500
Received: from hermes.mixx.net ([212.84.196.2]:33806 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129183AbQLEQTm>;
	Tue, 5 Dec 2000 11:19:42 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: test12-pre5
Date: Tue, 05 Dec 2000 16:48:10 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A2D0E3A.99312EA3@innominate.de>
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 976031354 20403 10.0.0.90 (5 Dec 2000 15:49:14 GMT)
X-Complaints-To: news@innominate.de
To: Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> NOTE! There's another change to "writepage()" semantics than just dropping
> the "struct file": the new writepage() is supposed to mirror the logic of
> readpage(), and unlock the page when it is done with it. This allows the
> VM system more visibility into what IO is pending (which the VM doesn't
> take advantage of yet, but now it can _truly_ use the same logic for both
> swapout and for dirty file writeback).

Or maybe readpage should *not* unlock the page.  What if we wanted to
follow the writepage immediately by traversing the page's buffers?  We'd
have to lock the page again, and we wouldn't know what happened in the
interim.

Thanks for fixing the (struct file *)'s!  (major wart gone)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
