Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUFHLHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUFHLHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbUFHLHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:07:07 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:29767 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S264970AbUFHLHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:07:02 -0400
Message-ID: <40C59DCF.5080704@ThinRope.net>
Date: Tue, 08 Jun 2004 20:06:55 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Bruce Guenter <bruceg@em.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clone() <-> getpid() bug in 2.6?
References: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org> <20040607182016.GA8727@em.ca>
In-Reply-To: <20040607182016.GA8727@em.ca>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Guenter wrote:
> On Mon, Jun 07, 2004 at 11:35:23PM +0000, Linus Torvalds wrote:
> 
>>On Sun, 6 Jun 2004, Kalin KOZHUHAROV wrote:
>>
>>>Well, not exactly sure about my reply, but let me try.
>>>
>>>The other day I was debugging some config problems with my qmail instalation and I ended up doing:
>>># strace -p 4563 -f -F
>>>...
>>>[pid 13097] read(3, "\347\374\375TBH~\342\233\337\220\302l\220\317\237\37\25"..., 32) = 32
>>>[pid 13097] close(3)                    = 0
>>>[pid 13097] getpid()                    = 13097
>>>[pid 13097] getpid()                    = 13097
>>>[pid 13097] getuid32()                  = 89
>>>[pid 13097] getpid()                    = 13097
>>>[pid 13097] time(NULL)                  = 1086497450
>>>[pid 13097] getpid()                    = 13097
>>>[pid 13097] getpid()                    = 13097
>>>[pid 13097] getpid()                    = 13097
>>
>>qmail is a piece of crap. The source code is completely unreadable, and it 
>>seems to think that "getpid()" is a good source of random data. Don't ask 
>>me why.
> 
> 
> In this case, however, it has nothing directly to do with qmail.  This
> is tcpserver, and tcpserver only uses getpid for two things: printing
> out status lines with the PID in them (which seems perfectly valid to
> me), and once when adding to random initializer for DNS requests.
> 
> This strace pattern seemed rather odd to me, so for comparison I straced
> my own tcpserver setups, and could not get them to produce more than two
> getpid calls per connection.  Something is wrong with this trace,
> possibly some weirdness in a patch, like whatever the SSL library is
> doing.

Yes, it is strange. I'll have a look at the applied patches. Without SSL there is no such getpidding :-)
Will post you (not LKML) if I find the culprit.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
