Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265207AbSJRQs0>; Fri, 18 Oct 2002 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265209AbSJRQsZ>; Fri, 18 Oct 2002 12:48:25 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14609 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265207AbSJRQsT>;
	Fri, 18 Oct 2002 12:48:19 -0400
Date: Fri, 18 Oct 2002 09:53:51 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018165350.GC7286@kroah.com>
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <200210181514.g9IFEErG006526@turing-police.cc.vt.edu> <20021018161828.A5523@infradead.org> <200210181830.28354.russell@coker.com.au> <20021018173339.A7481@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018173339.A7481@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:33:39PM +0100, Christoph Hellwig wrote:
> 
> And exactly these hooks harm.  They are all over the place, have performance
> and code size impact and mess up readability.  Why can't you just maintain
> an external patch like i.e. mosix folks that nead similar deep changes?

They do not have performance impacts (with the minor exception of
networking, which has been talked about before), and now they do not
have any size impact.  As for readability, that is also not an issue.

And no, we do not want to maintain an external patch, as that's not what
this project is about.  At the first kernel summit, Linus said he wanted
this patch to allow people to pick their own security model (so we
didn't have to end up with SELinux as a default, vs. LIDS, vs.
SubDomain, vs. whatever.)  At the second kernel summit, this patch was
again talked about, and was stated that it would be accepted, as we met
the goals initially talked about (mediation of kernel objects, not
syscalls or auditing.)

The whole idea of this patch is for it to be in the kernel, having it
external, doesn't help anyone out, they might as well just do their own
thing, like they were doing before.

Now there is no size impact, and no performance impact if you disable
the config option (which is the default right now!)  I'm all for
dropping the syscall too, if the SELinux people, or someone else doesn't
speak up as to why they really need it.  The hooks have a real design
and purpose, as we've constantly pointed out in our documentation, and
they have been validated by others in their USENIX papers.

I know you've never liked this patch, I'm sorry.  Lots of other people
do :)

thanks,

greg k-h
