Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUGCR7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUGCR7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUGCR7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 13:59:16 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:32874 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S265195AbUGCR7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 13:59:14 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH/2.4.26] Avoid kernel data corruption through /dev/kmem
Date: Sat, 3 Jul 2004 20:13:45 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407011605.29386.blaisorblade_spam@yahoo.it> <20040702131844.GC7679@logos.cnet>
In-Reply-To: <20040702131844.GC7679@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200407032013.45234.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 15:18, venerdì 2 luglio 2004, Marcelo Tosatti ha scritto:
> On Thu, Jul 01, 2004 at 04:05:29PM +0200, BlaisorBlade wrote:

> This looks much better for inclusion. But do you actually have a problem
> with write to /dev/kmem not returning correct error code?
The *other* time I spoke about error code... but it seems you don't have 
noticed the part *below* of my mail, the one where I describe what I complain 
about kernel memory corruption... read below:

> If you convince me there are good enough reasons we can try this on
> 2.4.28-pre.

> > We need to check if do_write_mem == -EFAULT.
> > In fact, without that check, we could execute this:
> >
> > do_write_mem returns -EFAULT;
> > wrote = -EFAULT;
> >
> > buf += wrote; //i.e. buf -= EFAULT (14);
> >
> > ... read other data from buf, and write it to kernel memory
And those datas are crap, obviously: the app wanted to write *buf to kernel 
memory, not *(buf-14), so we can have data corruption.

> > (actually on special circumstances, i.e. p < high_memory &&
> >  p + count > high_memory).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

