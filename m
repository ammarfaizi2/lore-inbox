Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbQLLBFq>; Mon, 11 Dec 2000 20:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbQLLBFg>; Mon, 11 Dec 2000 20:05:36 -0500
Received: from web215.mail.yahoo.com ([128.11.68.115]:36365 "HELO
	web215.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131305AbQLLBFV>; Mon, 11 Dec 2000 20:05:21 -0500
Message-ID: <20001212003455.11975.qmail@web215.mail.yahoo.com>
Date: Mon, 11 Dec 2000 16:34:55 -0800 (PST)
From: Jean Fekry Rizk <jeanfekry@yahoo.com>
Subject: Re: Linking with kernel code (Makefile)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The character device is a good idea!!!
But how would the device's mmap be implemented?
I know how the read and write work, but they copy the data from one space
to another, which would be slow if there is much communication. Because
this looses the benifits of shared memory

About the kernel linking, I'm not making a module driver, 
I'm trying to recompile the kernel after adding my file (kshared.c)
I guess I should be able to access all structures and functions in the
kernel, if I succeed to link correctly with the files containing those
functions and structures, but I'm not so good at make files.


--- "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
> > What I want to do:
> >     create a shared memory segment between user space and kernel space
> 
> Create a character device.
> Have the driver allocate memory.
> Let the user mmap() it.
> 
> >     I can't link with the array or the function, this also happens
> with
> > all functions that are not defined in 'ksyms'
> >     Even though I declared 'newseg' and 'shm_segs' as 'extern' in my
> file
> ...
> > But while making bzImage, it gives the error unresolved external
> 'newseg'
> > 
> > So my question is how can I link to the kernel source code, or am I
> not
> > allowed to?
> 
> You are not allowed to use interfaces that are not exported.
> This is partly to prevent you from depending on code that is
> very likely to change, and partly to prevent a Microsoft Linux
> or similar abuse of the GPL.
> 
> If you really need it, make a non-module driver. Maybe after
> that gets accepted into the main kernel you could convince
> Linus to export the function you want for module use.


__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
