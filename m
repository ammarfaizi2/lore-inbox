Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbVKIUPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbVKIUPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbVKIUPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:15:20 -0500
Received: from gambit.vianw.pt ([195.22.31.34]:26778 "EHLO gambit.vianw.pt")
	by vger.kernel.org with ESMTP id S1161219AbVKIUPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:15:18 -0500
Message-ID: <437258CD.8060206@esoterica.pt>
Date: Wed, 09 Nov 2005 20:15:09 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Accessing file mapped data inside the kernel
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I posted about this a few days ago but got no responses
so far! I think this should be a trivial question for those
involved in the kernel internals. May be I didn't develop
the problem enough to be understood.

So, here is the question reformulated.

A given file system must supply a procedure for mmap.

int <fsname>_file_mmap(struct file * file, struct vm_area_struct * vma)
{
   int addr;
   addr=generic_file_mmap(file,vma);
   <Code to access addr pointed bytes or vma->vm_start>
   return addr;
}

I could verify that "addr" is what is returned to the user as
a pointer to a string of bytes that maps a file when a user
program calls mmap or mmap2.

In the user program, I can access those bytes (read/write)
as, for ex., a char pointer.

I don't know how to access those bytes inside the kernel
at the point <Code to access addr pointed bytes or vma->vm_start>

First trys led the program that invoked mmap to block.
I thought that there's something to do with a previous
    down_write(&current->mm->mmap_sem);
If I execute
    up_write(&current->mm->mmap_sem);
before accessing the data the block situation does not
occur anymore. I would like to hear something about
this.

Anyway, I tryed to use "copy_from_user" but I got
garbage, not the file contents! Using "strncpy" crashes
the kernel (UML)!

Can someone please write a fragment of code to safely
access those bytes, copying them to and from a
kernel char pointed area so that they are read/written
to the file?

Thank you very much.
Paulo

