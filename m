Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKBXob>; Thu, 2 Nov 2000 18:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbQKBXoV>; Thu, 2 Nov 2000 18:44:21 -0500
Received: from c100.clearway.com ([199.103.231.100]:56586 "EHLO
	mercury.clearway.com") by vger.kernel.org with ESMTP
	id <S129148AbQKBXoO>; Thu, 2 Nov 2000 18:44:14 -0500
From: Paul Marquis <pmarquis@iname.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3A01FC44.8A43FE8B@iname.com>
Date: Thu, 02 Nov 2000 18:44:05 -0500
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.15pre3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: select() bug
In-Reply-To: <E13rTfB-00023L-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I see your point, thanks.  A couple of comments/questions:

- Does this make sense with devices with small kernel buffers?  From
my experimentation, pipes on Linux have a 4K buffer and tend to be
read and written very quickly.

- If I'm correct that pipes have a 4K kernel buffer, then writing 1
byte shouldn't cause this situation, as the buffer is well more than
half empty.  Is this still a bug?

Semantic issues aside, since Apache does the test I mentionned earlier
to determine child status and since it could be misled, should this
feature be turned off?

Thanks for your input.

Alan Cox wrote:
> > I'm not exactly sure what you mean by this statement.  Would you mind
> > explaining further?
> 
> Well take a socket with 64K of buffering. You don't want to wake processes
> waiting in select or in write every time you can scribble another 1460 bytes
> to the buffer. Instead you wait until there is 32K of room then wake the
> user. That means that there is one wakeup/trip through userspace every 32K
> rather than potentially every time a byte is read the other end

-- 
Paul Marquis
pmarquis@iname.com

If it's tourist season, why can't we shoot them?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
