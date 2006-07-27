Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWG0Poz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWG0Poz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWG0Poz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:44:55 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:46743 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750794AbWG0Poy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:44:54 -0400
Subject: Re: Require mmap handler for a.out executables
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0607270816500.4168@g5.osdl.org>
References: <1153909881.746.39.camel@localhost>
	 <20060727150737.GA29521@infradead.org>
	 <Pine.LNX.4.64.0607270816500.4168@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 17:44:16 +0200
Message-Id: <1154015056.9543.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> > > diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> > > index f312103..5638acf 100644
> > > --- a/fs/binfmt_aout.c
> > > +++ b/fs/binfmt_aout.c
> > > @@ -278,6 +278,9 @@ static int load_aout_binary(struct linux
> > >  		return -ENOEXEC;
> > >  	}
> > >  
> > > +	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
> > > +		return -ENOEXEC;
> > > +
> > 
> > These checks need a big comment explanining why they are there, else people
> > will remove them again by accident.
> 
> Since we fixed the /proc problem in a different way, I decided that it 
> might be best to leave the a.out stuff alone, at least for now. It is 
> conceivable that somebody actually might be using executables on some 
> strange filesystem that doesn't support mmap, although I can't for the 
> moment think of any good reason. 

what do think about giving this a spin in -mm for some time and see if
it will break for somebody.

Andrew, please include it.

Regards

Marcel


