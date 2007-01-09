Return-Path: <linux-kernel-owner+w=401wt.eu-S932414AbXAIXOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXAIXOz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbXAIXOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:14:55 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:38485 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbXAIXOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:14:54 -0500
Date: Tue, 9 Jan 2007 17:14:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Mimi Zohar <zohar@us.ibm.com>,
       akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: mprotect abuse in slim
Message-ID: <20070109231449.GA4547@sergelap.austin.ibm.com>
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com> <1168312045.3180.140.camel@laptopd505.fenrus.org> <20070109094625.GA11918@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109094625.GA11918@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (hch@infradead.org):
> On Mon, Jan 08, 2007 at 07:07:25PM -0800, Arjan van de Ven wrote:
> >
> > > Starting with the fdtable, would it help if we move the
> > > fdtable tweaking out of slim itself and into helpers?  Or
> > > can you recommend another way to implement this functionality.
> >
> > Hi,
> >
> > maybe this is a silly question, but do you revoke not only the current
> > fd entries, but also the ones that are pending in UNIX domain sockets
> > and that are already being sent to the process? If not.. then you might
> > as well not bother ;)
> 
> Exactly.  What these folks want is revoke (maybe more fine grained, but
> that's not the point).  And guess what folks, revoke is not trivial,
> otherwise we'd have it.  If you want to volunteer to implement a full-blown
> revoke that's fine, but
> 
>   a) it belongs into core code
>   b) needs to be done right

Whatever happened with Pekka's revoke submissions?  Did you lose
interest after
http://www.kernel.org/pub/linux/kernel/people/penberg/patches/revoke/2.6.19-rc1/revoke-2.6.19-rc1,
or was it decided that the approach was unworkable?

Now, what slim needs isn't "revoke all files for this inode",
but "revoke this task's write access to this fd".  So two functions
which could be useful are

	int fd_revoke_write(struct task_struct *tsk, int fd)
	int fd_revoke_write_iter(struct task_struct *tsk,
			(int *)need_revoke(struct task_struct *tsk, int fd))

Anyway I'll get going on rebasing Pekka's latest patch (pending
his reply) and providing the above two functions on top of that.

-serge
