Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJQUbN>; Thu, 17 Oct 2002 16:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbSJQUbN>; Thu, 17 Oct 2002 16:31:13 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:38414 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262122AbSJQUbM>;
	Thu, 17 Oct 2002 16:31:12 -0400
Date: Thu, 17 Oct 2002 13:36:52 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017203652.GB592@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017.131830.27803403.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017.131830.27803403.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:18:30PM -0700, David S. Miller wrote:
>    From: Greg KH <greg@kroah.com>
>    Date: Thu, 17 Oct 2002 11:53:52 -0700
>    
>    No, don't remove this!
>    Yes, it's a big switch, but what do you propose otherwise?  SELinux
>    would need a _lot_ of different security calls, which would be fine, but
>    we don't want to force every security module to try to go through the
>    process of getting their own syscalls.
>    
>    And other subsystems in the kernel do the same thing with their syscall,
>    like networking, so there is a past history of this usage.
> 
> Well, here is another issue about opaque interfaces, how are we
> supposed to audit whether 32-bit/64-bit execution environments
> will be able to work correctly?
> 
> If there is no description available of what the types are going
> through these system calls, it cannot be handled properly.
> 
> It is one thing if some existing legacy user interface we can't make
> go away creates this kind of problem, but when we add new system calls
> we ought to be much much more careful.
> 
> I brought this up months ago, and I believe someone (perhaps you :),
> said "oh I'll bring that up with the folks, thanks" and I've seen
> no action taken since.

Yes, you pointed this out to me, and I said that.  Very sorry, I got
busy with other things and I didn't follow through, my fault.

> Are the LSM modules that exist now using portable types in the objects
> passed into sys_security?  Note that pointers and things like "long"
> are not allowed as types, for example, those would need to be translated.

Yes, you are correct, they better be implemented properly, or they will
not work.

> The more I look at LSM the more and more I dislike it, it sticks it's
> fingers everywhere.  Who is going to use this stuff?  %99.999 of users
> will never load a security module, and the distribution makers are
> going to enable this NOP overhead for _everyone_ just so a few telcos
> or government installations can get their LSM bits?

Um, I know a few distro makers that are going to implement this and are
seriously conserding shipping SELinux soon.  Debian included :)

And (ignoring the network hooks) there is not a measurable overhead for
these hooks.  We have documented this many times (OLS paper, USENIX
paper, etc.)  With the patch I'm about to submit, disabling the option
makes them go away entirely.

thanks,

greg k-h
