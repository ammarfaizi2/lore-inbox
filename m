Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVFKTpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVFKTpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVFKTob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:44:31 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:45544 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261803AbVFKTno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EcJubBH4ZWfXZ4M/JiDDoMtORAvTAbPpPRRzppV8UJHNcLgIR5zQUIZ5Cdx67Zn0O8f81xfrY5kYY4KOzns9DJm7ALGlK1oSsqCc6YjHGjH2td5/cNpMvrNyQwnXE8WM9cqxPdhi/cKfuC28JpRwPbx1faSyZGZOAhkHPAo7/sU=
Message-ID: <9a8748490506111243314d811@mail.gmail.com>
Date: Sat, 11 Jun 2005 21:43:40 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Ilan S." <ilan_sk@netvision.net.il>
Subject: Re: 'hello world' module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506111511.02581.ilan_sk@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506111511.02581.ilan_sk@netvision.net.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/05, Ilan S. <ilan_sk@netvision.net.il> wrote:
> Hello dear professionals!
> 
> I would be very thankful if anybody prompt me what's wrong.
> I'm trying to build the "Hello world" module from O'Reilly's "Linux device
> drivers" and that is what I get:
> 
I don't have that book, so I can't really say, but here's an example
from "Linux Kernel Development, 2ed" by rml
(http://rlove.org/kernel_book/)


/*
 * hello.c - Hello, World! As a Kernel Module
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

/*
 * hello_init - the init function, called when the module is loaded.
 * Returns zero if successfully loaded, nonzero otherwise.
 */
static int hello_init(void)
{
        printk(KERN_ALERT "I bear a charmed life.\n");
        return 0;
}

/*
 * hello_exit - the exit function, called when the module is removed.
 */
static void hello_exit(void)
{
        printk("KERN_ALERT "out, out, brief candle!\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Shakespeare");


To build the module above, make a Makefile in the same dir with this
line in it :

obj-m := hello.o


Then build like this:

make -C /kernel/source/location SUBDIRS=$PWD modules


Works for me :)

Of course there's lots of additional info in the book. Robert wrote a
rather good one, it's well worth checking out if you ask me.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
