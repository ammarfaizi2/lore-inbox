Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKNQ4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKNQ4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVKNQ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:56:50 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:29841 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbVKNQ4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:56:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JloPaLQoTzFDFDkdKq4nU1DLlkYhM3qLDik9ErE7KU++6N+5lOPgf5bGodYFGZBRcyokz0Re2k9LG/iUVMBIhj3gdXUruCJuaQQytnqPh/PGauBfYh3J4eLgucL76uuuIOt8sqLBXER6T6tpVzXEkIioNJu4K6PydXOfVbYAkpo=
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
From: Badari Pulavarty <pbadari@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4378B1FB.1060201@rtr.ca>
References: <4378ADB2.7040905@rtr.ca>
	 <1131982550.2821.41.camel@laptopd505.fenrus.org>  <4378B1FB.1060201@rtr.ca>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:56:38 -0800
Message-Id: <1131987398.24066.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 10:49 -0500, Mark Lord wrote:
> Arjan van de Ven wrote:
> > On Mon, 2005-11-14 at 10:30 -0500, Mark Lord wrote:
> ..
> >>My Notebook computer has 2GB of RAM, and the 2.6.xx kernel seems quite
> >>happy to leave hundreds of MB of dirty unsync'd pages laying around
> ..
> >>/proc/sys/vm/dirty_expire_centisecs = 3000 (30 seconds)
> >>/proc/sys/vm/dirty_writeback_centisecs = 500 (5 seconds)
> ..
> > do you have laptop mode enabled? That changes the behavior bigtime in
> > this regard and makes the kernel behave quite different.
> 
> No.  Laptop-mode mostly just modifies the dirty_expire
> and related settings, and I have them set as shown above.
> But there's also this:
> 
> /proc/sys/vm/laptop_mode = 0
> 
> > also if these are files written to by mmap, the kernel only really sees
> > those as dirty when the mapping gets taken down
> 
> They certainly show up in the counts in /proc/meminfo under "Dirty",
> so I assumed that means the kernel knows they are dirty.
> 
> A simple test I do for this:
> 
> $ mkdir t
> $ cp /usr/src/*.bz2  t    (about 400-500MB worth of kernel tar files)
> 
> In another window, I do this:
> 
> $ while (sleep 1); do echo -n "`date`: "; grep Dirty /proc/meminfo; done
> 
> And then watch the count get large, but take virtually forever
> to count back down to a "safe" value.
> 
> Typing "sync" causes all the Dirty pages to immediately be flushed to disk,
> as expected.
> 
> Here's what the monitoring of /proc/meminfo shows,
> on an otherwise mostly idle system after having done
> the big file copies noted earlier:
> 
> Mon Nov 14 10:40:22 EST 2005: Dirty:          481284 kB
> Mon Nov 14 10:40:23 EST 2005: Dirty:          479680 kB


Interesting. Since you have a very easy to reproduce case -
can you write a program to do posix_fadvise(POSIX_FADV_DONTNEED)
on those files in directory "t" and see what happens ?

Thanks,
Badari

