Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUG2GQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUG2GQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUG2GQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:16:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7570 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262768AbUG2GPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:15:55 -0400
Date: Wed, 28 Jul 2004 23:15:48 -0700
From: Paul Jackson <pj@sgi.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040728231548.4edebd5b.pj@sgi.com>
In-Reply-To: <87llh3ihcn.fsf@ibmpc.myhome.or.jp>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank-you for considering my comments.

OGAWA wrote:
> because it limits the range when struct kbentry
> was changed.  (I think this change is likely)

I'm not sure I understand this comment -- but I am guessing that
you mean that:

> +	unsigned char s, i;
> +	unsigned short v;

would limit s, i, and v if struct kbentry was changed to have
larger types (short or int, say) for these.

Good point.

Would it work to use larger types for local variables s, i, and v now,
in order to avoid the ugly macro, as in:

	unsigned int s, i, v;

However, if I have guessed incorrectly, then this idea may make no
sense.  If so, sorry about that.


> key_map is pointer, so ARRAY_SIZE() can't use.

Yes - good point.


> Anyhow these will be warned by gcc.

If larger types, as I wrote above, were used for s, i, and v,
then does gcc still warn?


> Although overhead is insignificance, I'd hated to add overhead of this
> test because test is not needed right now.

Code clarity matters most here.  If the code had been crystal clear
to the casual reader, then the initial mistake, of removing the
range checking, probably would never have occurred in the first place,
and we human beings would have already saved more time than we can ever
hope to save by optimizing this code.

You are absolutely correct that overhead is insignificant.

But code clarity - that is very significant <smile>.

Let all the essential details be spelled out, in the simplest
most easily read, C statements that can be found to express it.

Each line of code we put in the kernel will be read by many people
doing various things.  They will be more likely to have a correct
understanding of our code if it is clear and simple, with a minimum
of surprises.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
