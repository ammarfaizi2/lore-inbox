Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUECVQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUECVQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUECVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:16:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264012AbUECVQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:16:13 -0400
Date: Mon, 3 May 2004 22:16:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davidm@hpl.hp.com, bunk@fs.tum.de,
       eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040503211607.GG17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de> <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org> <20040501161035.67205a1f.akpm@osdl.org> <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org> <20040501175134.243b389c.akpm@osdl.org> <16534.35355.671554.321611@napali.hpl.hp.com> <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org> <20040503140251.274e1239.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503140251.274e1239.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 02:02:51PM -0700, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > How about this patch? 
> 
> Seems sane.  For after 2.6.6 ;)
> 
> > +static inline long open(const char * name, int mode, int flags)
> > +{
> > +	return sys_open((const char __user *) name, mode, flags);
> > +}
> 
> We may as well stick the get_fs()/set_fs() stuff in here as well - all
> callers need to do it, after all.  After which it would best be uninlined.

I'd rather kill open() completely - we only have a handful of in-tree users
and there's no good reason to keep that crap, AFAICS.  I'm gathering the
list of in-tree callers of open()/lseek()/close() and so far a lot of them
look buggy.  More on that later...
