Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVGTPX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVGTPX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVGTPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:23:56 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:39481 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261358AbVGTPXz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eY46zp6UrUIy6Jh/DfUc8wwmGobRp6FLehb7iBsUgbiELsaYht/KdjNVhu8IxUukegZia7ddqFLPbRr9927k8FHvW4KfxHPG99JWdOG0ya7nZTjj5HOaoWd+IKp+3azGRWW2qw+mR0TzKAxqPYBRJTo2nWQPdmrrRvgj4k/u/Jk=
Message-ID: <69304d1105072008237dd21e08@mail.gmail.com>
Date: Wed, 20 Jul 2005 17:23:52 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: a 15 GB file on tmpfs
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, naber@inl.nl,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050720144421.GK7050@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507201416.36155.naber@inl.nl>
	 <20050720132006.GI7050@harddisk-recovery.com>
	 <dbljub$mgm$1@news.cistron.nl>
	 <20050720144421.GK7050@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Wed, Jul 20, 2005 at 01:35:07PM +0000, Miquel van Smoorenburg wrote:
> > In article <20050720132006.GI7050@harddisk-recovery.com>,
> > Erik Mouw  <erik@harddisk-recovery.com> wrote:
> > >On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> > >AFAIK you can't use a 15 GB tmpfs on i386 because large memory support
> > >is basically a hack to support multiple 4GB memory spaces (some VM guru
> > >correct me if I'm wrong).
> >
> > I'm no VM guru but I have a 32 bit machine here with 8 GB of
> > memory and 8 GB of swap:
> >
> > # mount -t tmpfs -o size=$((12*1024*1024*1024)) tmpfs /mnt
> > # df
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > /dev/sda1             19228276   1200132  17051396   7% /
> > tmpfs                 12582912         0  12582912   0% /mnt
> >
> > There you go, a 12 GB tmpfs. I haven't tried to create a 12 GB
> > file on it, though, since this is a production machine and it
> > needs the memory ..
> 
> I stand corrected.
> 
> > So yes that appears to work just fine.
> 
> The question is if it's a good idea to use a 15GB tmpfs on a 32 bit
> i386 class machine. I guess a real 64 bit machine will be much faster
> in handling suchs amounts of data simply because you don't have to go
> through the hurdles needed to address such memory on i386.
> 
> 
> Erik
> 

On 32bit: you would have to use read() and write() or mmap() munmap()
mremap() to perform your own paging, since you can't fit 15GB on a 4GB
address space.

On 64bit: you would simply mmap() the whole file and you are done.

Most probably the cost of programming and debugging the hand-made
paging on 32bit machines will cost more than the difference for a
64bit machine.

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
