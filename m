Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVC3TNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVC3TNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVC3TJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:09:55 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:9872 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262407AbVC3TGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:06:18 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 03/12] uml: export getgid for hostfs
Date: Wed, 30 Mar 2005 20:05:26 +0200
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20050322162123.890086BA6F@zion> <200503240302.29153.blaisorblade@yahoo.it> <20050329114529.GA26005@infradead.org>
In-Reply-To: <20050329114529.GA26005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503302005.26311.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 13:45, Christoph Hellwig wrote:
> On Thu, Mar 24, 2005 at 03:02:28AM +0100, Blaisorblade wrote:
> > In this moment I need to clean up the missing symbol. If anyone wants to
> > remove the code using this, then he might post a patch explictly removing
> > it, and getting it refused probably.
> >
> > Or at least CC uml-devel when discussing those problems. I'm not
> > currently able to find on marc.theaimsgroup.com the mail you talk about.
> > Can you please provide the URL to the discussion? (even on any other
> > archive you like, obviously).
>
> My unaswered reply to the first submission is at
>
> http://groups-beta.google.com/group/linux.kernel/messages/de9504fe5963ccd1,
>0c05294c599b22b1,eab26a4ed3f8ff17?thread_id=16c905c7e28e7498&mode=thread&noh
>eader=1&q=uml-export-getgid-for-hostfs#doc_eab26a4ed3f8ff17
>
> (sorry, couldn't find it on marc), it's been Cc'ed to the lists you sent
> the patch to.
Sorry, I wasn't clear... I read *that* answer, but it says "as mentioned in 
the discussion about ROOT_DEV", and I couldn't find it.

Also, I'd like to know whether there's a correct way to implement this (using 
something different than root_dev, for instance the init[1] root directory 
mount device). I understand that with the possibility for multiple mounts the 
"root device" is more difficult to know (and maybe this is the reason for 
which ROOT_DEV is bogus, is this?), but at least a check on the param 
"rootfstype=hostfs" could be done.

> > That said, there are people still using that code, so it should be kept
> > in.
>
> But the code is totally bogus, so it should _not_ be kept.
>
> > Also, you blocked an important patch (the one adding ->release to
> > hw_interrupt_type) saying that *perhaps* UML should avoid having any hard
> > irq, a la S390. You forced so the merge of a very ugly patch manually
> > calling what should have been UML's release method (i.e.
> > free_irq_by_irq_and_dev) in every place calling free_irq() (and in fact
> > one was missed at first). Might you reconsider your position on that
> > issue ? (URL of the discussion below)
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=3&s=uml+irq&q=b
> >
> > The patch adding the generic handling is this one:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109834481320519&w=2
>
> I still think it's a really bad idea.
Hmm, you don't seem very talkative, sorry. You can explain why doing that 
hurts anyhow. You only said very vaguely "there is another way to do 
this" (still to prove). And actually this caused the merge, in place of that 
clean patch, of the current hack, described above in the quoted text.

> But I'm not the irq code maintainer, 
> it could very well be Ingo overrides me.

Ok, this is nice. I'll repost the (updated) patch CC'ing Ingo Molnar (unless 
there's another Ingo).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

