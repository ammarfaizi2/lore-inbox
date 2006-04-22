Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWDVRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWDVRwp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDVRwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:52:44 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54429 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750786AbWDVRwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:52:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=x0annKF/57efHyQ+wJyy0n6A3yy337FZ0M/198rpF8+IhwwCrhb0Zn+8/mAXjRjaEN+ohUX/g0thBN4fQ9SrWaJ+DRuKiaKCJXmvuZLciy8DV/xRgKKzMcxW2vn2XZhdQE0uYDPnJu+egL+Z36ajMByqAU88e1zpXbEEkOVN0XM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Date: Sat, 22 Apr 2006 10:32:38 +0200
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604212016.36859.blaisorblade@yahoo.it> <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221032.40232.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 09:06, Heiko Carstens wrote:
> > For UML, instead, it's important to set that some peculiar syscalls are
> > not traced, that the mask is 1-extended and that errors are reported.
> >
> > So, I suggest a "flags" parameter for this. Sadly, we're using the
> > ptrace() syscall and there's no 5th argument normally, we could either
> > use it (IIRC some calls use the 5th regs indeed), or pass as "data" a
> > struct with flags and the mask.
> >
> > The flags could be:
> >
> > MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> > MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> > MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set
> > differently than the default).
> >
> > probably with a reasonable prefix to avoid namespace pollution (something
> > like "PT_SC_-").
>
> You might as well introduce yet another ptrace call which returns the
> number of system calls and for this ptrace call force user space to pass a
> complete bitmap. Sounds easier to me.

I thought to something such, but it's interesting to have auto-complete and I 
didn't like the idea of querying the syscall number... It's true that my 
suggestion wasn't (maybe) that marvellous either.



As a side note, I'd like to inform you that this patch made it to the LWN 
front page... I'm sorry that the article cannot yet be read (it's subscribers 
only for now and until next Thursday):

http://lwn.net/Articles/179829/

The article is positive about the patch and shows interest, on the wave of all 
the various existing virtualization ideas.

> > > The tracing process won't see
> > > any of the non existant syscalls it requested to see anyway.

> > No, you misunderstood the code, it does the opposite very different - the
> > loop

> Looks I missed a few "!"s :)
Don't worry! Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
