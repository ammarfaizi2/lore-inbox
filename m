Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274811AbRIUUGt>; Fri, 21 Sep 2001 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIUUGk>; Fri, 21 Sep 2001 16:06:40 -0400
Received: from [208.129.208.52] ([208.129.208.52]:52237 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274809AbRIUUGW>;
	Fri, 21 Sep 2001 16:06:22 -0400
Message-ID: <XFMail.20010921131017.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BAB9790.8DB400C@distributopia.com>
Date: Fri, 21 Sep 2001 13:10:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: "Christopher K. St. John" <cks@distributopia.com>
Subject: RE: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Sep-2001 Christopher K. St. John wrote:
>  To save further pointless argument, I'm calling the
> experiment "/dev/yapoll". 
> 
>  Specifically, I've added code to return the initial
> state of the fd's as they are added to the interest
> list. It seems to work ok so far, but I'll be doing
> some benchmarking this weekend. I will post a patch
> if no problems turn up.

By reporting the initial state of the connection will make
/dev/epoll to be a hybrid interface and looks pretty crappy to me.
You'll be able, eventually, to skip only the first system call anyway.
You still won't be able to use an interface like :

        if (ioctl(DATA_READY))
                read();

Coz if 2000 bytes arrives on the terminal and you read only 1000 bytes
you won't receive another POLLIN event and you'll get stuck in the ioctl().
You can avoid this in two ways :

1) test ( w/ or w/o hints ) the readyness of the terminal, that means /dev/poll

2) add inside the network code functions that are going to maintain the state
        of the connections directly by writing your own fd-state token.
        Tha means
        1) when the data is exhausted it clears the data-ready bit
        2 ) when the tx buffer is full it clears the terminal-ready bit

But, again, you're going to have a state reporting interface vs an event reporting
one like /dev/epoll




- Davide

