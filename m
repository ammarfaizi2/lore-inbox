Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUHYQVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUHYQVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHYQVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:21:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:39350 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268115AbUHYQVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:21:38 -0400
Date: Wed, 25 Aug 2004 18:18:37 +0200
From: Olaf Dabrunz <od@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Patch] TIOCCONS security
Message-ID: <20040825161837.GB21687@suse.de>
Mail-Followup-To: Linux kernel list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <20040825151106.GA21687@suse.de> <20040825161504.A8896@infradead.org> <20040825161630.B8896@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040825161630.B8896@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Aug-04, Christoph Hellwig wrote:
> On Wed, Aug 25, 2004 at 04:15:04PM +0100, Christoph Hellwig wrote:
> > > Still, I believe that administrators and operators would not like any
> > > user to be able to hijack messages that were written to the console.
> > > 
> > > The only user of TIOCCONS that I am aware of is bootlogd/blogd, which
> > > runs as root. Please comment if there are other users.
> > 
> > Oh, common.  Do your basic research - this has been rejected a few times
> > and there have been better proposals.  Just use goggle a little bit.
> 
> Umm, I'm smoking crack.  Sorry, for some reason I took this for another
> TIOCGDEV submission without reading.

(Don't do this to me. ;))

BTW, I found that xterm -C is using this. xterm(1x) is misleading
though because it states that /dev/console must belong to the user of
xterm -C. I did not do a thorough check, but since the availability of
the "-C" option depends on TIOCCONS (or SRIOCSREDIR) being available,
this should work without /dev/console belonging to the user of TIOCCONS.

Anyway, there are other ways to read log messages from X. One is to use
xconsole on /dev/xconsole and have syslogd provide filtered messages to
/dev/xconsole.

Changing the ownership on /dev/console causes security problems (that
user can usually access the current virtual terminal anytime, and the
current one may not belong to him). This does not happen with
/dev/xconsole, so it is possible to change the ownership of
/dev/xconsole to the first local X user.

While /dev/xconsole may not be the same as /dev/console, e.g. boot
script messages do go to the console (that's why bootlogd uses
TIOCCONS), it seems to be the best bet so far. It may even be possible
to pipe boot messages to /dev/xconsole.

The bottom line is, that I do not see why normal users should be able to
use TIOCCONS. Hijacking console output is a security problem, which has
been found quite some time ago on SunOS as well
(http://www.cert.org/advisories/CA-1990-12.html).

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux AG, Nürnberg

