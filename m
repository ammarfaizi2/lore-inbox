Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313778AbSDPTh3>; Tue, 16 Apr 2002 15:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313850AbSDPTh2>; Tue, 16 Apr 2002 15:37:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20298 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313778AbSDPTh2>; Tue, 16 Apr 2002 15:37:28 -0400
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
In-Reply-To: <200204161555.g3GFtmH03317@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2002 13:30:19 -0600
Message-ID: <m1r8lfigqc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> This patch tries to split arch/i386 up into machine specific directories 
> (similar to the way arch/arm is done).  The idea is to separate out those 
> machines which don't look like standard PCs (particularly from an SMP 
> standpoint).  For the current kernel, all it really does is to get the visws 
> stuff into a separate directory (arch/i386/visws).  I've also taken some files 
> which aren't going to be used by non-pc SMP machines (mainly related to mpbios 
> and ioapic) and placed them into arch/i386/generic.

A couple of comments.
- There is no way to build a generic kernel, that just needs
  a command line to select the architecture.  Something that is important
  for installers.  Even better would auto detection of the platform from
  firmware information, but you can't always do that.

- By just allowing redirecting setup_memory_region you don't allow for
  architectures that don't have the 384K memory hole.

- The hooks you add aren't used and are so generic it isn't obvious what
  they are supposed do from their names.

- setup_arch.h is nasty.  What code it has depends on what it is defined
  when it is included.  Couldn't 2 headers to this job better?  Or better yet
  can't you just use function calls?

And of course you don't look at allowing different firmware implementations,
but I'm doing that, so it is covered. :)

Eric
