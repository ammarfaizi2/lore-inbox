Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTDAI4D>; Tue, 1 Apr 2003 03:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbTDAI4D>; Tue, 1 Apr 2003 03:56:03 -0500
Received: from infa.abo.fi ([130.232.208.126]:10251 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S262190AbTDAI4C>;
	Tue, 1 Apr 2003 03:56:02 -0500
Date: Tue, 1 Apr 2003 12:07:22 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200304010907.h3197Mi20706@infa.abo.fi>
To: ramands@indiatimes.com, <linux-kernel@vger.kernel.org>
Subject: Re: Compilation Error: variable has intializer but incomplete type
In-Reply-To: <200304010401.JAA16708@WS0005.indiatimes.com>
References: <200304010401.JAA16708@WS0005.indiatimes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i am trying to learn and write device driver on linux kernel 2.4 redhat
>  distribution 
>
>iam getting compilation errors for driver code.
>struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
>NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
>NULL };
>
>ERROR -> my_ops has intializer but incomplete type

This is not a good way to do it. See e.g. fs/pipe.c#read_fifo_fops
for an easier approach:

struct file_operations read_fifo_fops = {
        llseek:         no_llseek,
        read:           pipe_read,
        write:          bad_pipe_w,
        poll:           fifo_poll,
        ioctl:          pipe_ioctl,
        open:           pipe_read_open,
        release:        pipe_read_release,
};


-- 
Marcus Alanen
maalanen@abo.fi
