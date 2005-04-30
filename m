Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVD3SUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVD3SUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVD3SUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:20:32 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:40200 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261328AbVD3SUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:20:24 -0400
Date: Sat, 30 Apr 2005 20:20:16 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, hch@infradead.org, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430182016.GA41358@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	hch@infradead.org, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org> <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 07:07:56PM +0200, Miklos Szeredi wrote:
> > But you don't need a new system call to bind an fd.
> > 
> > "mount --bind /proc/self/fd/N mount_point" works, try it.
> 
> Ahh, yes :)
> 
> Still proc_check_root() has to be relaxed, to allow dereferencing link
> under a different namespace.  Maybe the check should be skipped for
> capable(CAP_SYS_ADMIN) or similar.
> 
> What do people think about that?

To me it looks like an atrocious hack that works only because of the
way the implementation is done and not really by design.  A well
defined interface where you want to do is explicitely said is way less
annoying long term.  I don't know what the right approach would be
(join <ns> vs. exec in <ns> vs. clone in <ns>) or even what a
namespace reference should look like (fd, pid, something else), and
probably only Al has a good idea of that.  Al, you've been quite
silent here.  What do you think the right method/interface would be to
start an interactive shell in a pre-existing different namespace?

  OG.
