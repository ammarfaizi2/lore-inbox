Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKBWyS>; Thu, 2 Nov 2000 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbQKBWyI>; Thu, 2 Nov 2000 17:54:08 -0500
Received: from c100.clearway.com ([199.103.231.100]:11278 "EHLO
	mercury.clearway.com") by vger.kernel.org with ESMTP
	id <S129144AbQKBWx5>; Thu, 2 Nov 2000 17:53:57 -0500
From: Paul Marquis <pmarquis@iname.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3A01F07C.1DB597CE@iname.com>
Date: Thu, 02 Nov 2000 17:53:48 -0500
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.15pre3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: select() bug
In-Reply-To: <E13rSpZ-0001z2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess in theory, you're right, though if a write() could succeed,
shouldn't select() say that it would?

And this assumes you're calling select() with a timeout.  In Apache,
the caretaker process wakes up periodically and polls the pipe with a
timeout of zero.  If it gets back the pipe is not writable, it kills
the process.  With this false negative situation, this is a bad thing.

Alan Cox wrote:
> 
> > that are log file handlers are dead.  If select() reports it can't
> > write immediately, Apache terminates and restarts the child process,
> > creating unnecessary load on the system.
> 
> Is there anything saying that select has to report ready the instant a byte
> would fit. Certainly its better for performance to reduce the context switch
> rate by encouraging blocking

-- 
Paul Marquis
pmarquis@iname.com

If it's tourist season, why can't we shoot them?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
