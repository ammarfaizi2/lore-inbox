Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSDYLn5>; Thu, 25 Apr 2002 07:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSDYLn4>; Thu, 25 Apr 2002 07:43:56 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:21679 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313089AbSDYLnq>; Thu, 25 Apr 2002 07:43:46 -0400
Message-ID: <3CC7EBC3.6030707@antefacto.com>
Date: Thu, 25 Apr 2002 12:42:59 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ebuddington@wesleyan.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm think this is not possible at the moment.

The file of the executing process is in use as the backing store for
one or more live virtual memory areas, so changing it could
corrupt the processes using those areas. Hence you can't umount.

Now the Mach kernel has a MAP_COPY flag to the mmap system call
which would do what you want, but this is mucho complex/messy,
so don't hold your breath for a linux implementation.

A related note on shared libraries is you don't get the
"text file busy" message if you  update them while they're in use,
like you do for executable files. The reason is MAP_DENYWRITE
is ignored for security reasons. I think Eric Biederman has
a workaround though?

So in summary if you want a process to run independently of
a filesystem, make it static and run it from a ramdisk.

Padraig.

Eric Buddington wrote:
> Is there any way to dissociate a process from its on-disk binary?  In
> other words, I want to start 'foo_daemon', then unmount the filesystem
> it started from. It seems to me this would be reasonably accomplished
> by loading the binary completely into memory first ro eliminate the
> dependence.
> 
> Is this possible, or planned? Are there intractable problems with it
> that I don't see?
> 
> Eric Buddington

