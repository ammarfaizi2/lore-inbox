Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVD3QtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVD3QtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVD3Qrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:47:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63164 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261291AbVD3QrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:47:11 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050430083313.GB23253@infradead.org>
References: <E1DPnOn-0000T0-00@localhost>
	 <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050430083313.GB23253@infradead.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114879626.4180.2093.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 30 Apr 2005 09:47:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 01:33, Christoph Hellwig wrote:
> On Mon, Apr 25, 2005 at 08:07:34PM +0100, Jamie Lokier wrote:
> > Pavel Machek wrote:
> > > > > ... is the same as for the same question with "set of mounts" replaced
> > > > > with "environment variables".
> > > > 
> > > > Not quite.
> > > > 
> > > > After changing environment variables in .profile, you can copy them to
> > > > other shells using ". ~/.profile".
> > > > 
> > > > There is no analogous mechanism to copy namespaces.
> > > 
> > > Actually, after you add right mount xyzzy /foo lines into .profile,
> > > you can just . ~/.profile ;-).
> > 
> > Is there a mount command that can do that?  We're talking about
> > private mounts - invisible to other namespaces, which includes the
> > other shells.
> > 
> > If there was a /proc/NNN/namespace, that would do the trick :)
> 
> I don't think you need a /proc/NNN/namespace, /proc/NNN/mounts already
> contains a mount table.  It's pretty trivial to write a small shellscript
> to parse that, compare with the current namespace and do all mount/umounts
> to make them fit the other processes namespace.  Real problem here are
> filesystems that don't implement ->show_options or do so only partially
> so that some options are lost.

The other problem is: How would new mounts  in any of these namespaces
propogate to other namespaces owned by the same user? 

I mean, how will the other namespace's belonging to the same user, be
able to pull the mounts into their namespaces?  shared subtree won't be
a solution because these namespaces won't have a parent-child
relationship to begin with, for the propogation to be set up.


RP



> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

