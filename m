Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSEVNmk>; Wed, 22 May 2002 09:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSEVNmj>; Wed, 22 May 2002 09:42:39 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:41227 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313743AbSEVNmg>;
	Wed, 22 May 2002 09:42:36 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Date: Wed, 22 May 2002 15:40:57 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: AUDIT: copy_from_user is a deathtrap.
CC: linux-kernel@vger.kernel.org, acme@conectiva.com.br
X-mailer: Pegasus Mail v3.50
Message-ID: <5E8AE8C18EA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed cc a bit]

On 22 May 02 at 14:23, Denis Vlasenko wrote:
> > On 22 May 02 at 12:27, Denis Vlasenko wrote:
> > > > As Linus and others pointed out, copy_{to_from}_user has its uses and
> > > > will stay, but something like:
> > >
> > > I don't say 'kill it', I say 'rename it so that its name tells users what
> > > return value to expect'. However, one have to weigh
> >
> > Why?
> 
> Why what? Why rename copy_to_user? Because in its current form people

Why rename it. 

> misunderstand its return value and misuse it.
> We can keep unmodified version of copy_to_user for some time for
> compatibility.

Function name is not documentation. Documentation documents function
API, or, in case documentation is not available, source does it.
copy_to_user_dude_I_return_uncopied_length_on_error_not_EFAULT_parameters_are_same_as_for_memcpy() 
is unacceptable name, and anything shorter does not document things 
you must know.

> > From copyin/out descriptions sent yesterday if you want same source code
> > running on all (BSD,SVR4,OSF/1) platforms, you must do
> >
> > if (copyin()) return [-]EFAULT;
> 
> But if I am new to Linux and just want to write my first piece of kernel
> code, copyout() is even worse than copy_to_user(): 
> it too lacks info of what it can return (0/1, 0/-EFAULT, # of copied bytes,

Hey, please change sys_read(). I'm used that read() returns -1 on error,
but now in kernel it returns some strange negative value. Please fix it.

I'm not sure that I want to use kernel which contains code written
by people who do not read API documentation. I expect that everyone 
here tests every branch in code he writes at least once - and such test
would (f.e.) quickly reveal that read(fd, NULL, 1000) does not return -1 &
set errno to EFAULT, but instead returns complete success (1000) on
affected sound drivers.

No. copy_*_user interface is documented since 2.1.0, only bad old
verify_area() in older kernels returned -EFAULT on error, and I do
not believe that coders who coded for 2.0.x did not notice completely
different interface (copy_from_user instead of verify_area + memcpy_fromfs)
during last almost 6 years.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
