Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSD2RVh>; Mon, 29 Apr 2002 13:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSD2RVg>; Mon, 29 Apr 2002 13:21:36 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:1785 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S312973AbSD2RVf>; Mon, 29 Apr 2002 13:21:35 -0400
Message-ID: <3CCD811E.8689F4B0@redhat.com>
Date: Mon, 29 Apr 2002 18:21:34 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Russell King wrote:
>  > Kernel 2.5.8... Devfs devfs_open() bypasses the normal chrdev_open
>  > and blkdev_open functions, and misses out taking the BKL.  2.5.10 is
>  > the same.
>  >
>  > Certainly the tty layer (and probably many of the other devices as
>  > well) require the BKL to be taken before calling the open method.
> 
> Has the time come to push the BKL down into all of the driver open()s?
> It's going to be a lot of work, but it has to happen eventually, right?

I'm not convinced of that. It's not nearly a critical path and it's
better to get even the "dumb" drivers safe than to risk having big
security holes in there for years to come.
