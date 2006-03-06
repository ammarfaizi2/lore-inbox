Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWCFW1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWCFW1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWCFW1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:27:14 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:48039 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932406AbWCFW1N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:27:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jQJBaqiQXi9EUwBHHcC09mr6OTui8Im+KagAxvUL3T7KlWlgaqJQvGgnakEq6Xpupt9UmaDrD8Ey27nMWqhx3XPkx9m16v1KF/dna6D3prY4UfAqSqXr4w1WUQ3h52bOqImRtX+wfW9Qpmw2CRk0CkCKWtPwcyMJraF3BJ6Gx4Y=
Message-ID: <9a8748490603061427r1b140a3clf7528464e231b730@mail.gmail.com>
Date: Mon, 6 Mar 2006 23:27:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk,
       andrea@suse.de, michaelc@cs.wisc.edu, James.Bottomley@steeleye.com,
       axboe@suse.de
In-Reply-To: <9a8748490603061408r5f4f7509v6d39a7e39d36ca6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <20060306140541.16a41cd2.akpm@osdl.org>
	 <9a8748490603061408r5f4f7509v6d39a7e39d36ca6d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/6/06, Andrew Morton <akpm@osdl.org> wrote:
> > "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> > >
> > > Where do we go from here ?
> > >
> >
> > If you can test just
> >
> >         2.6.16-rc5 + linus.patch + git-scsi-misc.patch
> >
> > then we'd have a clearer idea.
> >
> Sure, I'll get right on it.
> I'll post the results in 15min or so.
>

Ok, a plain 2.6.15-rc5 + linus.patch + git-scsi-misc.patch results in this :

Slab corruption: start=f4812d14, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c028f61b>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f4812cc8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](_stext+0x3feffd68/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f4812d60, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02367ef>](init_dev+0x5cf/0x630)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Slab corruption: start=f4812d14, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c028f61b>](sr_do_ioctl+0x11b/0x270)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f4812cc8, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](_stext+0x3feffd68/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f4812d60, len=64
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02367ef>](init_dev+0x5cf/0x630)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
