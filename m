Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUIPJXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUIPJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIPJXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:23:24 -0400
Received: from imap.gmx.net ([213.165.64.20]:8094 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267881AbUIPJVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:21:14 -0400
X-Authenticated: #1725425
Date: Thu, 16 Sep 2004 11:33:58 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Peter Jones <pjones@redhat.com>
Cc: axboe@suse.de, Kai.Makisara@kolumbus.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
Message-Id: <20040916113358.56e50a9a.Ballarin.Marc@gmx.de>
In-Reply-To: <1095280344.20046.32.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
	<Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
	<20040915195024.GA3899@suse.de>
	<1095280344.20046.32.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 16:32:24 -0400
Peter Jones <pjones@redhat.com> wrote:

> It'd be pretty easy to add device-type defaults to my patch, and make
> them registered by the individual drivers.

Even this won't get us very far. Maybe we could probably find suitable
defaults for most modern hardware, but this still won't help users of
older or non-standard hardware.
For example,  remember LG's abuse of CACHE_FLUSH for firmware updates.

Here I've done some grepping over cdrecord and k3b:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109269018602502&w=2

> 
> I'm just not sure I see the point in doing it.  Without them, you get a
> _somewhat_ reasonable set of defaults if you don't want to mess with it,
> and distros can easily set their own per-device tables for each device
> type, vendor specific commands, etc.  It's even pretty simple to just
> deny everything, if that's what distro maintainers or sysadmins want to
> do.

Per device-type filters are unavoidable (unless we deny everything by
default).
This is especially true for MODE_SELECT. See here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109274414601613&w=2

> 
> Not doing it also means that the device driver code itself needs less
> maintenance, and won't need to be updated every time some vendor comes
> up with a new READ command.  That makes it easier if for example distros
> decide to push new command tables as updates, I think.

Why not deny everything and have a "smart" user space tool that assigns
filters to devices during startup? The tool's database could be updated
regularly by distributors.

> 
> > A good reminder of why the whole thing is a mess :-)
> 
> It sure is.

IMHO all the more reason to keep all knowledge about individual devices
(and thus the need to provide updates) out of the kernel.

BTW: My impression was, that in the long term applications should be
adopted to work safely with increased capabilities. Is this still the
goal?

mfg
