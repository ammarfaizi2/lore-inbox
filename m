Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVELCTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVELCTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVELCTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:19:10 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:2903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261310AbVELCS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:18:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PzGn+Q8syGmRHMacAi1VQlmJKD/EdVrO8DVJKdKoTkybeTusKBjUE8d5juO0+JAW+aFpcafYJgNPxwsNYd6qcos/kMhSz2zUpAPFhDQVakCy0vtosexlh51z3/+Ito7T9bRH+KdCmQjojsO+ufqsLnEaYp4GcjS3UsWujXbfsAU=
Message-ID: <a4e6962a05051119181e53634e@mail.gmail.com>
Date: Wed, 11 May 2005 21:18:55 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Cc: Ram <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <20050512010215.GB8457@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <40t37-7ol-5@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it>
	 <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Jamie Lokier <jamie@shareable.org> wrote:
> 
> Please read carefully: I've described what _current_ kernels do.
> 

I guess I misread when you wrote:

>>
>>You can't do a lot with the new namespace, because of the security
>>restrictions on mount() on a foreign namespace.  That's what I meant
>>about the "small fixes" - get rid of the current->namespace checks and
>>it'll be usable.
>>
>>I don't see the purpose of current->namespace and the associated mount
>>restrictions at all.  I asked Al Viro what it's for, but haven't seen
>>a reply :(  IMHO current->namespace should simply be removed, because the
>>"current namespace" is represented just fine by
>>current->fs->rootmnt->mnt_namespace.
>>

That sounds an awful lot like you want to make changes to the current
support in the kernel.

> It's a poorly understood area of the kernel, and I'm attempting to
> clarify it.  This talk of new system calls for entering a namespace
> makes no sense when you can _already_ do some things that people
> haven't realised the kernel does.
> 

IMHO part of the reason its so poorly understood is that people aren't
using it.  That's why I suggest we use some of the proposed patches
which open up name space operations to common users.  There are some
security checks (like the one brought up justifying the CAP_SYS_ADMIN
permissions on CLONE_NS) that need to be added, before we start
removing others -- and I'm quite concerned that Viro hasn't weighed in
on any of these new patches, I wonder if its because this thread seems
to have gone off the deep end.

          -eric
