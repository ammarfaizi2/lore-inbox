Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317654AbSFLHLz>; Wed, 12 Jun 2002 03:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317655AbSFLHLy>; Wed, 12 Jun 2002 03:11:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26121 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317654AbSFLHLx> convert rfc822-to-8bit; Wed, 12 Jun 2002 03:11:53 -0400
Message-ID: <3D06F42E.9040602@evision-ventures.com>
Date: Wed, 12 Jun 2002 09:11:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206111824050.16686-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Wed, 12 Jun 2002, Rusty Russell wrote:
> 
>>The only really sane way to implement "CONFIG_SMALL_NO_INLINES" that I
>>can think of is to have headers do
> 
> 
> inlines, when used properly, are _not_ larger than not inlining.

Actually I have monitored linux/include/linux/*.h for improper
and inadequate inlining. Well what have I to say. In comparision
to the last time I checked (around 4 years ago) the situation
got *much* better. I was not able to save more then around 1k of
code from the kernel... How ever some offenders are:

1. elv_next_request(request_queue_t *q)

-  just too big

2. seq_putc(struct seq_file *m, char c)

- just not worth the trobule.

3. seq_puts(struct seq_file *m, const char *s)

- calls strlen and memset - really not worth inlining.

4. void DQUOT_INIT(struct inode *inode)
  void DQUOT_DROP(struct inode *inode)
DQUOT_PREALLOC_SPACE_NODIRTY(struct in
int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)ode *inode, qsize_t

and friends from quotaops - all to be to be inlines.

But the situation got really really better over time!
Please note that I didn't look at include/asm/*.h files, where
memset copy_from/to_user strlen and friends reside, which
result in quite a lot of inline code.

