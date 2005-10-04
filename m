Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVJDUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVJDUUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVJDUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:20:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23493 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964960AbVJDUUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:20:48 -0400
Date: Tue, 4 Oct 2005 21:20:47 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Leimbach <leimy2k@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
Message-ID: <20051004202047.GP7992@ftp.linux.org.uk>
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com> <20051004194301.GO7992@ftp.linux.org.uk> <3e1162e60510041307q3fc900e7tdcf96eb268816eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1162e60510041307q3fc900e7tdcf96eb268816eac@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 01:07:48PM -0700, David Leimbach wrote:
> On 10/4/05, Al Viro <viro@ftp.linux.org.uk> wrote:
> > On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> > > Hmm no responses on this thread a couple days now.  I guess:
> > >
> > > 1) No one cares about private namespaces or the fact that they make
> > > /etc/mtab totally inconsistent.
> > > 2) Private Namespaces aren't important to anyone and will never be
> > > robust unless someone who cares, like me, takes it over somehow.
> > > 3) Everyone is busy with their own shit and doesn't want to deal with
> > > me or mine right now.
> >
> > 4) If you insist on having /etc/mtab the same file in all namespaces,
> > you obviously will have its contents not matching at least some
> > of them.  Either have it separate in each namespace where you want
> > to see it, or simply use /proc/self/mounts instead.
> 
> Well I guess it's my fault to some extent with the subject line.  I
> don't really care about /etc/mtab so much except that I'd like it to
> be consistent if it is going to be there.  I'd rather it do one of two
> things.  Show me my current process's namespace accurately or just the
> stuff that's global to all namespaces.  Right now it's kind of in
> between.

/etc/mtab is just a regular file; no more, no less.  It's a place used by
mount(8) and several other programs.  Kernel has nothing to do with it...

Obns: that can get tough.  Note that Plan 9 one is an approximation that
works well enough for most uses; if you play with mounting/unmounting/renaming
in sufficiently perverted ways, you'll get unusable /proc/<pid>/ns.  The
trouble being, they are luckier - they don't have to deal with many classes
of perversion we do, so their soluition wouldn't work well for Linux.
