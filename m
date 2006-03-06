Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCFVRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCFVRB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbWCFVRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:17:01 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:26119 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751601AbWCFVRA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:17:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r7jxsBj06Xj0t07uX+geuc5ExH0lvp4BLr1Gm7nw1/rgdzSQYvIBcvNghjZ2LqGecO8J0fX9M1HUnEbq77ZfZFD7ejiS9ewlKq5bNZFSJ4AnoqE3ddgFeQCUgEU/CjgFV54468baM2eX+W7KKHivafvIuSSDbpEibtWQxVRdOYI=
Message-ID: <9a8748490603061316y3347b7a3pd00a218548e3e134@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:16:57 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 6 Mar 2006, Jesper Juhl wrote:
> >
> > Hmm, is it just me or should that len= have read len=96 ???
> >
> > This is the change I made :
> >
> > --- linux-2.6.16-rc5-mm2/block/scsi_ioctl.c~    2006-03-06
> > 21:43:56.000000000 +0100
> > +++ linux-2.6.16-rc5-mm2/block/scsi_ioctl.c     2006-03-06
> > 21:43:56.000000000 +0100
> > @@ -568,7 +568,7 @@ int scsi_cmd_ioctl(struct file *file, st
> >                         hdr.dxferp = cgc.buffer;
> >                         hdr.sbp = cgc.sense;
> >                         if (hdr.sbp)
> > -                               hdr.mx_sb_len = sizeof(struct request_sense);
> > +                               hdr.mx_sb_len = SCSI_SENSE_BUFFERSIZE;
> >                         hdr.timeout = cgc.timeout;
> >                         hdr.cmdp = ((struct cdrom_generic_command __user*) arg)->cmd;
> >                         hdr.cmd_len = sizeof(cgc.cmd);
> >
> > did I mess up?
>
> That's not the one to change. It's the one in "sr_do_ioctl()", where it
> uses "sizeof(*sense)".
>

Ahh, so I did mess up - whoops - I just grep'ed for "sizeof(struct
request_sense)" :-(

I'll try it again (with the correct change) in a moment, after I've
tested Jens's "does no slab poison/debug make it go Oops" question...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
