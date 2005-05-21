Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVEUCjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVEUCjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 22:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVEUCjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 22:39:37 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:21856 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261640AbVEUCjc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 22:39:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGcffd1h0k2BsFa4YvBdiKc6V22sF784fbcckl84KWNDG0yB3S/RgZRYcojBZyytysq+IcR1l01iR45ISqLr+1ljwOcoMmSMvXbiFna2Z1drXH9k+EIPEnEcXtKshiYNWt2dFYrYkU2ZccaOED5wmMuPs7c+amlnjH2xCHWIVz4=
Message-ID: <3f250c71050520193921f76af8@mail.gmail.com>
Date: Fri, 20 May 2005 22:39:31 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc4-mm2: proc-pid-smaps.patch broke nommu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3f250c7105052019194934be66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050516021302.13bd285a.akpm@osdl.org>
	 <20050516191827.GG5112@stusta.de>
	 <3f250c7105052019194934be66@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

I guess that the code below you have to include in the
fs/proc/task_nommu.c. But I would like to replicate the error you
found and apply the code below to verify if it is correct. So if you
can explain how you got this error I can test the code below. If you
want to test the code below by yourself, let me know about the result
please.

static int show_smap(struct seq_file *m, void *v)
{
	return 0;
}

struct seq_operations proc_pid_smaps_op = {
	.start	= m_start,
	.next	= m_next,
	.stop	= m_stop,
	.show	= show_smap
};

BR,

Mauricio Lin.

On 5/20/05, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Hi Adrian,
> 
> How did you get this error? What is your configuration?
> 
> I would like to replicate it.
> 
> BR,
> 
> Mauricio Lin.
> 
> On 5/16/05, Adrian Bunk <bunk@stusta.de> wrote:
> > It seems proc-pid-smaps.patch is guilty for this nommu breakage in -mm:
> >
> > <--  snip  -->
> >
> > ...
> >   LD      vmlinux
> > fs/built-in.o(.text+0x32b08): In function `smaps_open':
> > /usr/src/ctest/mm/kernel/fs/proc/base.c:560: undefined reference to `_proc_pid_smaps_op'
> > make[1]: *** [vmlinux] Error 1
> >
> > <--  snip  -->
> >
> > cu
> > Adrian
> >
> > --
> >
> >        "Is there not promise of rain?" Ling Tan asked suddenly out
> >         of the darkness. There had been need of rain for many days.
> >        "Only a promise," Lao Er said.
> >                                        Pearl S. Buck - Dragon Seed
> >
> >
>
