Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbTDAKKT>; Tue, 1 Apr 2003 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbTDAKKT>; Tue, 1 Apr 2003 05:10:19 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42986 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262229AbTDAKKS>; Tue, 1 Apr 2003 05:10:18 -0500
Date: Tue, 1 Apr 2003 12:21:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: ramands@indiatimes.com, linux-kernel@vger.kernel.org
Subject: Re: Compilation Error: variable has intializer but incomplete type
Message-ID: <20030401102126.GA6128@wohnheim.fh-wedel.de>
References: <200304010401.JAA16708@WS0005.indiatimes.com> <200304010907.h3197Mi20706@infa.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304010907.h3197Mi20706@infa.abo.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 April 2003 12:07:22 +0300, Marcus Alanen wrote:
> 
> >i am trying to learn and write device driver on linux kernel 2.4 redhat
> >  distribution 
> >
> >iam getting compilation errors for driver code.
> >struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
> >NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
> >NULL };
> >
> >ERROR -> my_ops has intializer but incomplete type
> 
> This is not a good way to do it. See e.g. fs/pipe.c#read_fifo_fops
> for an easier approach:
> 
> struct file_operations read_fifo_fops = {
>         llseek:         no_llseek,
>         read:           pipe_read,
>         write:          bad_pipe_w,
>         poll:           fifo_poll,
>         ioctl:          pipe_ioctl,
>         open:           pipe_read_open,
>         release:        pipe_read_release,
> };

You should use the c99 initializers, though.

struct file_operations read_fifo_fops = {
        .llseek		= no_llseek,
        .read		= pipe_read,
        .write		= bad_pipe_w,
        .poll		= fifo_poll,
        .ioctl		= pipe_ioctl,
        .open		= pipe_read_open,
        .release	= pipe_read_release,
};

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
