Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264756AbTFYRfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTFYRfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:35:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:51207 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264756AbTFYRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:35:05 -0400
Date: Wed, 25 Jun 2003 18:49:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: mocm@mocm.de, Michael Hunold <hunold@convergence.de>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625184911.B29537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	mocm@mocm.de, Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org> <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler> <20030625175513.A28776@infradead.org> <20030625172703.GC1770@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030625172703.GC1770@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Wed, Jun 25, 2003 at 07:27:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 07:27:03PM +0200, Jörn Engel wrote:
> Christoph, while I agree with you, I also see why a lot of people just
> symlink /usr/include/linux to /usr/src/.../include/linux.  Pure
> convenience and the lack of a dedicated collection of userspace
> headers outside a distributions scope.

Well, that symlinking is okay as long as you never ever touch /usr/src/linux
again.

> Or did I miss something important and just exposed my stupidity?

No one said they can't be the same header and actually maintaining
them in the kernel tree is fine to.  Just put them in a different
location for userspace so you can update them independant of the
kernel.  Look at e.g. XFS - most headers in /usr/include/xfs/ are
just copied from fs/xfs/ in the kernel tree.  But they're always
the ones matching the libxfs you installed no matter what XFS
version your currently running kernel has (or no XFS at all).

And that's the fundamental issue here, the userland header must
be independant from the actually running kernel or some random
source tree that's somewhere on your disk.  Copying the content
to /usr/include/linux does work but it's really suboptimal.  You
don't want to upgrade your libc just because you want to be able
to use the new features in the dvb driver you just installed.
A separate dvb-dev packages that has a copy of those headers
in /usr/include/dvb is the much better choice.

