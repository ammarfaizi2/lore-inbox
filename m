Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSH0TYc>; Tue, 27 Aug 2002 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSH0TYc>; Tue, 27 Aug 2002 15:24:32 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:52234 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S313628AbSH0TYa>;
	Tue, 27 Aug 2002 15:24:30 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208271928.g7RJSgu12515@oboe.it.uc3m.es>
Subject: Re: block device/VM question
In-Reply-To: <Pine.LNX.4.44.0208271308190.3234-100000@hawkeye.luckynet.adm> from
 Thunder from the hill at "Aug 27, 2002 01:13:37 pm"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Tue, 27 Aug 2002 21:28:42 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Thunder from the hill wrote:"
> > And for the O_DIRECT flag we seem to do alloc_kiovec(1, &f->f_iobuf).
> 
> Perhaps we should go biovec here?
> 
> For you, if you can stand it you can even go directly into the dio stuff 
> from direct-io.c. You'll just need to know what to do. Or you fill your 
> information into some underway function.

Yes, the 2.5.31 code looks much much simpler. But you encouraged me to
look at 2.4.19 by pointing out that there has been support since 2.4.10,
so that's what I'm looking at!

I'm sure I'm just missing a couple of methods in some struct.  I'll test
a few on the way home in the train.  Things look good, just no methods to
do the work when the O_DIRECT flag is set. So I get EINVAL on every
read/write access.

I'm getting the hang of it. At every open of the device I look at the
file pointer that they're opening and check to see if it has an iobuff
field set. If not, I set it (and the O_DIRECT flag if necessary).
At every release of the device, I look at the file they're releasing
and if it has an iobuff field, I free it. I guess I should set a
flag to say "I did it", but for the moment, I guess it's only me
in the driver doing it. Kernel programming would be so much easier
if there were an explanation of what things were for :-).

I'll trace what happens in the generic_read() /write() stuff. They'll
be usiing the iobuf there.

Thanks.

Peter
