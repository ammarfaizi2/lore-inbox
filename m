Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVD3IdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVD3IdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVD3IdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:33:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14766 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261155AbVD3IdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:33:17 -0400
Date: Sat, 30 Apr 2005 09:33:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430083313.GB23253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jamie Lokier <jamie@shareable.org>, Pavel Machek <pavel@ucw.cz>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425190734.GB28294@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 08:07:34PM +0100, Jamie Lokier wrote:
> Pavel Machek wrote:
> > > > ... is the same as for the same question with "set of mounts" replaced
> > > > with "environment variables".
> > > 
> > > Not quite.
> > > 
> > > After changing environment variables in .profile, you can copy them to
> > > other shells using ". ~/.profile".
> > > 
> > > There is no analogous mechanism to copy namespaces.
> > 
> > Actually, after you add right mount xyzzy /foo lines into .profile,
> > you can just . ~/.profile ;-).
> 
> Is there a mount command that can do that?  We're talking about
> private mounts - invisible to other namespaces, which includes the
> other shells.
> 
> If there was a /proc/NNN/namespace, that would do the trick :)

I don't think you need a /proc/NNN/namespace, /proc/NNN/mounts already
contains a mount table.  It's pretty trivial to write a small shellscript
to parse that, compare with the current namespace and do all mount/umounts
to make them fit the other processes namespace.  Real problem here are
filesystems that don't implement ->show_options or do so only partially
so that some options are lost.

