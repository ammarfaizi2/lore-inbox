Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWG0PSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWG0PSn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWG0PSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:18:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751704AbWG0PSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:18:42 -0400
Date: Thu, 27 Jul 2006 08:18:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Eugene Teo <eteo@redhat.com>
Subject: Re: Require mmap handler for a.out executables
In-Reply-To: <20060727150737.GA29521@infradead.org>
Message-ID: <Pine.LNX.4.64.0607270816500.4168@g5.osdl.org>
References: <1153909881.746.39.camel@localhost> <20060727150737.GA29521@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jul 2006, Christoph Hellwig wrote:
>
> > diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> > index f312103..5638acf 100644
> > --- a/fs/binfmt_aout.c
> > +++ b/fs/binfmt_aout.c
> > @@ -278,6 +278,9 @@ static int load_aout_binary(struct linux
> >  		return -ENOEXEC;
> >  	}
> >  
> > +	if (!bprm->file->f_op || !bprm->file->f_op->mmap)
> > +		return -ENOEXEC;
> > +
> 
> These checks need a big comment explanining why they are there, else people
> will remove them again by accident.

Since we fixed the /proc problem in a different way, I decided that it 
might be best to leave the a.out stuff alone, at least for now. It is 
conceivable that somebody actually might be using executables on some 
strange filesystem that doesn't support mmap, although I can't for the 
moment think of any good reason. 

		Linus
