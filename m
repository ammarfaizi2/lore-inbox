Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267985AbRGXQuL>; Tue, 24 Jul 2001 12:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbRGXQuC>; Tue, 24 Jul 2001 12:50:02 -0400
Received: from sncgw.nai.com ([161.69.248.229]:22452 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267985AbRGXQtr>;
	Tue, 24 Jul 2001 12:49:47 -0400
Message-ID: <XFMail.20010724095229.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.4.21.0107241203260.25475-100000@weyl.math.psu.edu>
Date: Tue, 24 Jul 2001 09:52:29 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: user-mode port 0.44-2.4.7
Cc: Jonathan Lundell <jlundell@pobox.com>, Jan Hubicka <jh@suse.cz>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 24-Jul-2001 Alexander Viro wrote:
> 
> 
> On Tue, 24 Jul 2001, Davide Libenzi wrote:
> 
>> I would not call, to pretend the compiler to issue memory loads every time it access
>> a variable, a nontrivial way.
>> It sounds pretty clear to me.
> 
> You know, one of the nice things about C is that unless you abuse
> preprocessor, reading code doesn't require doing far lookups. Most
> of it can be read and understood with very little context. "Do it
> once when you declare a variable" goes against that and that's
> not a good thing.

Look, you're not going to request any kind of black magic over that variable.
You're simply telling the compiler the way it has to ( not ) optimize the code.
This is IMHO a declaration time issue.
Looking at this code :

while (jiffies < ...) {
        ...
}

the "natural" behaviour that a reader expects is that the "content" of the memory
pointed by  jiffied  is loaded and compared.
That content, not the content of a register loaded 100 asm instructions before the load.
If you like this code more :

for (;;) {
        barrier();
        if (jiffies >= ...)
                break;
        ...
}

It's clear that a declaration like :

__locked_access__ struct pio {
        int a, b, c;
};


for (;;) {
        ++a;
        if (a > b && c < a)
        ...
}

sounds a "Bad Thing"(tm) even to me.




- Davide

