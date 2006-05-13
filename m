Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWEMXeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWEMXeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWEMXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:34:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:30528 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964796AbWEMXeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:34:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=InWx6LOb4wUnSjiBv2VvZ4AQWHToU7hXpeKP7W7BHPC+J1FDrMGCyNWyrehYkV7lcYMwTU0wg3r5ojHwTAmC5WzmLOMGUAXc89Xa2lwlTYaUVAfcKuC3mUmZm5GvGx1dDGn4VJbU09bVyDHoCpBZzKmmzs9ZKu+OAgxjzrYoRI0=
Message-ID: <9a8748490605131634w73b8d40ax278fac343602123b@mail.gmail.com>
Date: Sun, 14 May 2006 01:34:13 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
Cc: linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Jochen_Sch=E4uble?=" <psionic@psionic.de>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <1147562300.12379.1.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605140107.18293.jesper.juhl@gmail.com>
	 <1147562300.12379.1.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Sun, 2006-05-14 at 01:07 +0200, Jesper Juhl wrote:
> > There are two code paths in drivers/mtd/devices/phram.c::phram_setup() that
> > will leak memory.
> > Memory is allocated to the variable 'name' with kmalloc() by the
> > parse_name() function, but if we leave by way of the parse_err() macro,
> > then that memory is never kfree()'d, nor is it ever used with
> > register_device() so it won't be freed later either - leak.
> >
> > Found by the Coverity checker as #593 - simple fix below.
>
> Applied; thanks. Please Cc me and/or linux-mtd@lists.infradead.org on
> MTD patches.
>
Sure thing, will do. The same problem exists in
drivers/mtd/devices/block2mtd.c, I'm cooking up a patch for that one
as we speak.


> (Ew. The parse_err() macro contains a 'return'. Who do I slap for that?)
>
Want me to fix the macro and the users of it?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
