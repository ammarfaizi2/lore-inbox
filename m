Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSH0Sgc>; Tue, 27 Aug 2002 14:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSH0Sgc>; Tue, 27 Aug 2002 14:36:32 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:49671 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316789AbSH0Sgb>;
	Tue, 27 Aug 2002 14:36:31 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271840.g7RIeiH08814@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: From "(env:" "ptb)" at "Aug 27, 2002 08:04:48 pm"
To: ptb@it.uc3m.es
Date: Tue, 27 Aug 2002 20:40:44 +0200 (MET DST)
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ago ptb wrote:"
> In dentry_open(), we get a struct file f = get_empty_filp(), and then
> fill out various of its fields with enormously obscure things.  And for
> the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).
> 
> I feel that the latter is all I want to do, and the question is to what,
> where (I'll clean up on release). Do I do this every time the devices
> _open() function is called? Or just once, and what do I do it to? I
> should do it to the struct file that gets passed into to the driver
> open()? I'll try that. And set the flag.

Well, that was fun! I checked that on entry into the devices
open function, the file->f_iobuf field was null, and then called
alloc_kiovec on it while I set the O_DIRECT flag on file-_f_flags.

The result was that all read/write calls on the device failed
with EINVAL! Whee!

But ioctls worked. Apparently I am supposed to fill out
some more fields of something else with some methods. Hmm. OK.
I'll look. I guess this will be the a_ops field of i_mapping.


Peter

