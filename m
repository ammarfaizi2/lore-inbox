Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTF2OLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTF2OLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:11:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16388 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265662AbTF2OLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:11:06 -0400
Date: Sun, 29 Jun 2003 16:24:59 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Willy TARREAU <willy@w.ods.org>, marcelo@conectiva.com.br,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629142459.GB359@pcw.home.local>
References: <20030629130952.GA246@pcw.home.local> <1056895780.1720.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056895780.1720.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 04:09:40PM +0200, Arjan van de Ven wrote:
> On Sun, 2003-06-29 at 15:09, Willy TARREAU wrote:
> > Hi Al and Marcelo,
> > 
> > while I was trying to get maximum restrictions on a chroot on 2.4.21-pre,
> > I found that it's always possible to mount a ramfs or a tmpfs on "..",
> > and then upload whatever I wanted in it. It's a shame because I was
> > trying to isolate network daemons inside empty, read-only file-systems,
> > and I discovered that this effort was worthless. To resume, imagine a
> > network daemon which does :
> 
> well...
> you need to be root to mount. If you're root you can break out of a
> chroot anyway....

not in all cases. for the classical "mkdir a; chroot a; chdir ..", you need a
writable directory to create "a" or an existing directory somewhere to serve
as a mount point. If neither of them is true, I don't see other means of
escaping the chroot. And here, ".." is the only one I could exploit, that's why
I proposed this patch which closes what is, to me, the only weakness in this
very particular case.

Cheers,
Willy

