Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSJUMWW>; Mon, 21 Oct 2002 08:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSJUMWW>; Mon, 21 Oct 2002 08:22:22 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:38570 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261352AbSJUMWU>;
	Mon, 21 Oct 2002 08:22:20 -0400
Date: Mon, 21 Oct 2002 15:43:23 -0400
From: Christoph Hellwig <hch@sgi.com>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>,
       Dan Higgins <djh@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021021154323.A14826@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
	Robin Holt <holt@sgi.com>, Dan Higgins <djh@sgi.com>
References: <20021017102146.A17642@sgi.com> <20021017223328.B25777@sgi.com> <20021018140546.M25310@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021018140546.M25310@sgi.com>; from jh@sgi.com on Fri, Oct 18, 2002 at 02:05:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:05:46PM -0500, John Hesterberg wrote:
> > +
> > +/* List of pagg (process aggregate) attachments */
> > +	struct pagg_list_s pagg_list;
> >  };
> > 
> > You don't need the header for an unreferences structure pointer.
> > And sched.h already includes far to many other headers..
> 
> It's not a structure pointer, it's the structure itself.

Umm, of course your right - sorry for the thinko (seeo? :))

> > +/* Host ID for the localhost */
> > +static uint32_t   jid_hid = DISABLED;
> > +
> > +static char 	   *hid = NULL;	    
> > +MODULE_PARM(hid, "s");
> > 
> > What's this for?
> 
> A host id (hid) is used as the top 32 bits of the job id.
> It gets initialized when you load the module, and can be
> changed with the JOB_SETHID call.

Any reason it's a char, not some interger?

> > Umm, no, ioctl on procfs is not the proper interfaces.  It looks like
> > all ioctl subcalls were syscalls initially (on unicos?), so doing the
> > as actual syscalls would at least be better.  Defining a proper
> > ascii file interface (i.e. echo start <arg1> <arg2> <etc.. > file)
> > sounds better.
> 
> What we *really* want would be a new syscall, but we can't lock down
> the syscall number in an external patch.  If we get integrated by Linus,
> then we'd love to cut over to a new syscall.  For now, the ioctl on
> /proc behaves almost identically to how a new syscall would,
> in that we pass down arguments in binary format, can copyout
> results, etc.  This is what the code on both ends is expecting.

Well, no.  It's not one syscall but many - and we really don't like adding
new multiplexer syscalls to linux, even less then normal ones.

You might want to look at fs/nfsd/nfsctl.c in 2.5 for a proper fs-based
interface for this.

