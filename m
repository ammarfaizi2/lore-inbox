Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTDWN4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTDWN4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:56:23 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:45277 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264045AbTDWN4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:56:21 -0400
Date: Wed, 23 Apr 2003 09:54:48 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423135448.GI354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423135814.GJ820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:58:14PM +0200, Stelian Pop wrote:
> On Wed, Apr 23, 2003 at 09:32:56AM -0400, Ben Collins wrote:
> 
> > > Can we see it please ?
> > 
> > Stelia,
> > 
> > http://www.linux1394.org/viewcvs/ieee1394/branches/linux-2.4
> > 
> > Click the "Download tarball" link and replace drivers/ieee1394 with what
> > you get.
> 
> Hey, that's a whole new version of ieee1394 subsystem, see below the
> diffstat.
> 
> There is *NO WAY* Marcelo will accept such a patch in the -rc stage.
> 
> >From a quick reading, your version seem to do exactly the same thing
> that my patch suggested (removing the spinlock around kernel_thread()),
> possibly with the locking being moved to the upper layer.
> 
> Do you have a stripped down patch correcting only the outstanding issues ?
> If you haven't, the choice will be either accepting my patch or 
> reverting your entire ieee1394 changes for the time being.
> 

Your patch leaves a race condition open. And no, I don't have a stripped
down patch. It's impossible for me to syncronize layers of linux1394
development with the timing of 2.4/2.5 development. The size of the
current 2.4 diff is only because of the amount of stuff merged from our
2.5 tree and a serious code cleanup (fixing locking problems like you saw
here).

Fixing your particular locking problem required removal of some shared
data, which required an additional API in the lowlevel subsystem. It's
not trivial to extrapolate just this from the patch.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
