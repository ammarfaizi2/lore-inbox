Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316907AbSEVJiT>; Wed, 22 May 2002 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSEVJiS>; Wed, 22 May 2002 05:38:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59150 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316907AbSEVJiO>; Wed, 22 May 2002 05:38:14 -0400
Message-Id: <200205220925.g4M9OwY01920@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Wed, 22 May 2002 12:27:14 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <mailman.1021642692.12772.linux-kernel2news@redhat.com> <200205210555.g4L5tfY29889@Port.imtp.ilyichevsk.odessa.ua> <20020521062118.GA13117@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2002 04:21, Arnaldo Carvalho de Melo wrote:
> > Oh. Do you think a pair of
> >
> > copy_to_user_or_EINVAL(...)
> > copy_to_user_return_residue(...)
> >
> > will help avoid such bugs?
> > It is possible to audit kernel once, move it to new functions
> > and deprecate/delete old one.
>
> As Linus and others pointed out, copy_{to_from}_user has its uses and will
> stay, but something like:

I don't say 'kill it', I say 'rename it so that its name tells users what
return value to expect'. However, one have to weigh 
long_but_easy_to_understand_name() versus cryptcnshrt() here. :-)

I usually vote for long_but_easy_to_understand_name(), but it's MHO only.

> #define copyin(...) (copy_from_user(...) ? -EFAULT : 0)
> #define copyout(...) (copy_to_user(...) ? -EFAULT : 0)

This falls in cryptcnshrt() category.
Will "new programmer" grasp form the name alone that it returns EFAULT?
/me in doubt. OTOH BSD folks may be happy.
--
vda
