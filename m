Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQJ2TqN>; Sun, 29 Oct 2000 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ2TqE>; Sun, 29 Oct 2000 14:46:04 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:11021 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129042AbQJ2Tpu>; Sun, 29 Oct 2000 14:45:50 -0500
Date: Sun, 29 Oct 2000 11:45:49 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, kumon@flab.fujitsu.co.jp,
        Andi Kleen <ak@suse.de>, Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
In-Reply-To: <E13pYis-0005Q0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0010291135570.11954-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2000, Alan Cox wrote:

> > The big question is: why is Apache using file locking so
> > much?  Is this normal behaviour for Apache?
> 
> Apache uses file locking to serialize accept on hosts where accept either has
> bad thundering heard problems or was simply broken with multiple acceptors

if apache 1.3 is compiled with -DSINGLE_LISTEN_UNSERIALIZED_ACCEPT it'll
avoid the fcntl() serialisation when there is only one listening port.  
(it still uses it for multiple listeners... you can read all about my
logic for that at <http://www.apache.org/docs/misc/perf-tuning.html>.)

is it appropriate for this to be defined for newer linux kernels?  i
haven't kept track, sorry.  tell me what versions to conditionalize it on.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
