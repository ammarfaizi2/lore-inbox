Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131485AbQLMOXU>; Wed, 13 Dec 2000 09:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbQLMOXK>; Wed, 13 Dec 2000 09:23:10 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:64651 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131485AbQLMOXD>; Wed, 13 Dec 2000 09:23:03 -0500
From: Christoph Rohland <cr@sap.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <21834.976708267@warthog.cambridge.redhat.com>
Organisation: SAP LinuxLab
Date: 13 Dec 2000 14:52:23 +0100
In-Reply-To: David Howells's message of "Wed, 13 Dec 2000 11:51:07 +0000"
Message-ID: <qwwvgsoig2w.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, 13 Dec 2000, David Howells wrote:
>>> I'm currently writing a Win32 emulation kernel module to help
>>> speed Wine up,
>                                            ^^^^^^^^^^^^^
>> fd = shm_open ("xxx",...)
>> ptr = mmap (NULL, size, ..., fd, offset);
> 
> I am doing this from within kernel space. I'd like to avoid doing
> the full open and mmap if possible. I was wondering if there're some
> shortcuts I could make use of.

There will be a 

struct file *shmem_file_setup(char * name, loff_t size)

which gives you an open sruct file to an unlinked file of size
size. You can then do

down(&current->mm->mmap_sem);
user_addr = (void *) do_mmap (file, addr, size, prot, flags, 0);
up(&current->mm->mmap_sem);

with that struct file. You can look at shmget/shmat in ipc/shm.c. They
use the same procedure form kernel space. 

All this will only work with my patch.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
