Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135520AbRANVuG>; Sun, 14 Jan 2001 16:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135546AbRANVt4>; Sun, 14 Jan 2001 16:49:56 -0500
Received: from chiara.elte.hu ([157.181.150.200]:12304 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135520AbRANVtr>;
	Sun, 14 Jan 2001 16:49:47 -0500
Date: Sun, 14 Jan 2001 22:49:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101141341570.4505-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101142245020.5053-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2001, Linus Torvalds wrote:

> > There is a Samba patch as well that makes it sendfile() based. Various
> > other projects use it too (phttpd for example), some FTP servers i
> > believe, and khttpd and TUX.
>
> At least khttpd uses "do_generic_file_read()", not sendfile per se. I
> assume TUX does too. Sendfile itself is mainly only useful from user
> space..

yes, you are right. TUX does it mainly to avoid some of the user-space
interfacing overhead present in sys_sendfile(), and to be able to control
packet boundaries. (ie. to have or not have the MSG_MORE flag). So TUX is
using its own sock_send_actor and own read_descriptor.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
