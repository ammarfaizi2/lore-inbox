Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVLTX2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVLTX2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVLTX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:28:53 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:12645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932213AbVLTX2w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:28:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uF3rJq2I25TYQti/X22gqEdYwp5Kf3jBpsHpIpo4d/YIs1CTQMSM6Z6VUkOnwgpQ7fXL3hBmP8vwvGqfGZ6XJo3zJo+6kLgbQhq5YWv7fk9Q60N1hsvxcTkILT6SRntWxbl03A+ld0OeQvVFo9LZIg1uTVV6ihd/L7L9gX2jRuo=
Message-ID: <9a8748490512201528u316abfc0h4e33c4e027039d5f@mail.gmail.com>
Date: Wed, 21 Dec 2005 00:28:51 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <17320.36949.269788.520946@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17320.36949.269788.520946@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Neil Brown <neilb@suse.de> wrote:
>
> I suggested an early of this patch some time ago to see if it was an
> acceptable approach and got zero feedback, which presumably means it
> is perfect:-)
>
> I've now reviewed it, fixed up the bits I didn't like, and tested it.
> It works and I am happy with in.
>
> So: I would like to submit it for inclusion in a future kernel.
>
> Comments, or acks, please :-)
>
[snip]
> +/* Sysfs attribute files are pollable.  The idea is that you read
> + * the content and then you use 'poll' or 'select' to wait for
> + * the content to change.  When the content changes (assuming the
> + * manager for the kobject supports notification), poll will
> + * return POLLERR|POLLPRI, and select will return the fd whether
> + * it is waiting for read, write, or exceptions.
> + * Once poll/select indicates that the value has changed, you
> + * need to close and re-open the file, as simply seeking and reading
> + * again will not get new data, or reset the state of 'poll'.

What if the value changes again between me closing and re-opening the file?

> + * Reminder: this only works for attributes which actively support
> + * it, and it is not possible to test an attribute from userspace
> + * to see if it supports poll.
> + */

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
