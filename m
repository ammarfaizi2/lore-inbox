Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbTDKUng (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDKUng (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:43:36 -0400
Received: from www.wotug.org ([194.106.52.201]:49197 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id S261805AbTDKUne (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:43:34 -0400
Message-Id: <5.2.0.9.0.20030411214458.0255e7b0@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 11 Apr 2003 21:55:14 +0100
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: RE: kernel support for non-english user messages
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBA7DD@orsmsx116.jf.inte
 l.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:20 10/04/2003, Perez-Gonzalez, Inaky wrote:
> > >Ruth Ivimey-Cook wrote:
> > >> results in the following in the kernel buffer:
> > >> "%s: name %p is %d\n", "stringval", 0x4790243, 44
> > > Debugging a non-klogd enabled kernel would be a pain
> >  Why?  Shouldn't it be easy to fix dmesg so it unmangles the output?
>s/non-klogd enabled/dmesg/
>Same thing - what I mean is that if you don't have some automatic
>means to recompose the messages, reading the direct output of
>the console (as sometimes you have to), becomes a mess.

What I was trying to suggest is that a new kernel thread was created that 
could recompose the messages and push them into the buffer that dmesg reads 
(is that /dev/kmsg?). Thus, the old dmesg and anything else would work fine.

However, for internationalization, another (user-space) process could send 
a signal to the kernel thread to say "stop that", take over the reading of 
unexpended messages and use getmsg() type mechanisms to push messages into 
the dmesg buffer. It might be nice if the kernel thread could be reawoken 
should the user-space process die, just in case (using SIGCHLD?)


Someone else mentioned they didn't like seeing loads of messages emitted. I 
do like it, as it means I can be sure that the OS has booted ok. However, 
how about enforcing the log level stuff more, so that a printk without a 
KERN_ log-level was ignored, and enabling a kernel-command line parameter 
that set the default log level of console messages. So if you did "vmlinux 
loglevel=crit" then you only get critical notices?

If we deprecated printk in favour of macros, e.g.:
#define printk_info(x, ...)  printk(KERN_INFO ## x, ...)

then it would be (fairly) easy to drop all the "info" level printk's from 
the kernel build, shouls the builder wish.

HTH,

Ruth 

