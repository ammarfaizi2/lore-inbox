Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWEOWIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWEOWIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWEOWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:08:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:59710 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964921AbWEOWIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jQ6nNUI6i1ZbDC16RB1aw+G5BEQM3M5/l7k3qBQskUET0QmxLs7+0LA/cPU6bi671xhM8Tlhaiuq83whPGfPSsKEOKui4LlA2llBxeWGW1GYVBaTUoRQOFjrH0U7C+yARdJbtYH/g9ltea8r2/7L9eXUO8pxcqp6AM92FKoWkuA=
Message-ID: <9a8748490605151508r4d9da784ib459a1f43fa52d49@mail.gmail.com>
Date: Tue, 16 May 2006 00:08:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Alan Cox" <alan@redhat.com>
Subject: Re: [PATCH 2/3] moxa: remove pointless check of 'tty' argument vs NULL
Cc: linux-kernel@vger.kernel.org, "Moxa Technologies" <support@moxa.com.tw>,
       "Martin Mares" <mj@ucw.cz>, "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>
In-Reply-To: <20060515215901.GB16994@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605152357.36018.jesper.juhl@gmail.com>
	 <20060515215901.GB16994@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/06, Alan Cox <alan@redhat.com> wrote:
> On Mon, May 15, 2006 at 11:57:35PM +0200, Jesper Juhl wrote:
> > Remove pointless check of 'tty' argument vs NULL from moxa driver.
>
> Can you leave those in for the moment but change them to BUG_ON() because
> I've seen the pop up once or twice. They may be fixed but Im not 100% sure
> yet.
>

I could, but would that really make sense?

As Alexey pointed out in the previous thread :

  >  ->write() is called via
  >
  >         tty->driver->write(tty, ...);
  >
  >  See? tty was already dereferenced.

And besides, we wouldn't ever get to the BUG_ON() because even if the
function did manage to get called it would then explode in the
  struct mxser_struct *info = tty->driver_data;
assignment, before it ever got to the BUG_ON() (that assignment could
ofcourse be moved as I did in my original patch, but that still leaves
Alexeys point in place).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
