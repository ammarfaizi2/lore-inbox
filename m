Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSEVKLe>; Wed, 22 May 2002 06:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316920AbSEVKLd>; Wed, 22 May 2002 06:11:33 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:41989 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315526AbSEVKLb>;
	Wed, 22 May 2002 06:11:31 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Date: Wed, 22 May 2002 12:08:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: AUDIT: copy_from_user is a deathtrap.
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        acme@conectiva.com.br
X-mailer: Pegasus Mail v3.50
Message-ID: <5E5257A4137@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 02 at 12:27, Denis Vlasenko wrote:

> > As Linus and others pointed out, copy_{to_from}_user has its uses and will
> > stay, but something like:
> 
> I don't say 'kill it', I say 'rename it so that its name tells users what
> return value to expect'. However, one have to weigh 

Why? OSF/1's copyin/copyout returns exactly same value which
our current copy_{to,from}_user does. You should not penalize
developers who read documentation.

> I usually vote for long_but_easy_to_understand_name(), but it's MHO only.
> 
> > #define copyin(...) (copy_from_user(...) ? -EFAULT : 0)
> > #define copyout(...) (copy_to_user(...) ? -EFAULT : 0)
> 
> This falls in cryptcnshrt() category.
> Will "new programmer" grasp form the name alone that it returns EFAULT?
> /me in doubt. OTOH BSD folks may be happy.

>From copyin/out descriptions sent yesterday if you want same source code 
running on all (BSD,SVR4,OSF/1) platforms, you must do

if (copyin()) return [-]EFAULT;

anyway, otherwise OSF/1 and SVR4 variants are wrong.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

