Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSAIO2i>; Wed, 9 Jan 2002 09:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIO22>; Wed, 9 Jan 2002 09:28:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44560 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286895AbSAIO2P>;
	Wed, 9 Jan 2002 09:28:15 -0500
Date: Wed, 9 Jan 2002 15:28:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About the request queue of block device
Message-ID: <20020109152807.E19814@suse.de>
In-Reply-To: <20020107213749.18573.qmail@web14911.mail.yahoo.com> <20020108081515.A19380@suse.de> <003801c198e0$5a85a9d0$4b53cc8e@zhujj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c198e0$5a85a9d0$4b53cc8e@zhujj>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08 2002, Michael Zhu wrote:
> Hi, Jens, thank you very much for you kindly reply.
> Your advice is very helpful to me. I've made some
> revisions according to your advice. The attachment
> contains some functions of mine. I don't know whether
> I am right. I've done some test, but failed.
> 
> In your mail you said that I can replace floppy
> blk_dev
> make_request_fn with my own that does the encryption
> on write and stacks a new buffer head on top of the
> other for READ, defining my own b_end_io function for
> that to decrypt on READ end I/O. How can I stacks a
> new buffer head on top of the other for READ? Is it
> necessary? How to implement this? Please give me a
> hand on this. Thank you very much.

Yes it's necessary, you can't go fiddling with b_end_io b_private  of a
buffer you don't own. See loop.c

> BTW, I've browsed the source code of __make_request()
> function in the ll_rw_blk.c file. Do I need to call
> the 'bh = create_bounce(rw, bh);' before I can access
> the bh->b_data? You know the buffer data may point

Inside make_request_fn, yes you need to bounce it yourself.

> into the high memory. My failure is because of this?

Probably not.

-- 
Jens Axboe

