Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbTDAJNi>; Tue, 1 Apr 2003 04:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbTDAJNi>; Tue, 1 Apr 2003 04:13:38 -0500
Received: from zork.zork.net ([66.92.188.166]:29119 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S262205AbTDAJNh>;
	Tue, 1 Apr 2003 04:13:37 -0500
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: ramands@indiatimes.com, <linux-kernel@vger.kernel.org>
Subject: Re: Compilation Error: variable has intializer but incomplete type
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: HATE SPEECH, EXCRETORY SPEECH
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: Marcus Alanen <marcus@infa.abo.fi>,
 ramands@indiatimes.com,  <linux-kernel@vger.kernel.org>
Date: Tue, 01 Apr 2003 10:24:53 +0100
In-Reply-To: <200304010907.h3197Mi20706@infa.abo.fi> (Marcus Alanen's
 message of "Tue, 1 Apr 2003 12:07:22 +0300")
Message-ID: <6u65pyd0yi.fsf@zork.zork.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <200304010401.JAA16708@WS0005.indiatimes.com>
	<200304010907.h3197Mi20706@infa.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Marcus Alanen quotation:

>>i am trying to learn and write device driver on linux kernel 2.4 redhat
>>  distribution 
>>
>>iam getting compilation errors for driver code.
>>struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
>>NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
>>NULL };
>>
>>ERROR -> my_ops has intializer but incomplete type
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

Aside from this, the main issue is the "has intializer but incomplete
type" error, which indicates that the definition of struct
file_operations has not been seen by the compiler.  This seems to be
defined (in 2.4.20, at least) by include/linux/fs.h, so Raman will
need to #include that file for the initialization to work.

-- 
Sean Neakums - <sneakums@zork.net>
