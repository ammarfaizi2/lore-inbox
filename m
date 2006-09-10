Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWIJKlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWIJKlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWIJKlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:41:17 -0400
Received: from nef2.ens.fr ([129.199.96.40]:46597 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750720AbWIJKlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:41:15 -0400
Date: Sun, 10 Sep 2006 12:41:05 +0200
From: David Madore <david.madore@ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060910104105.GB5865@clipper.ens.fr>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <20060908105238.GB920@elf.ucw.cz> <20060908225118.GB877@clipper.ens.fr> <20060909114037.GA4277@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909114037.GA4277@ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 12:41:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 11:40:38AM +0000, Pavel Machek wrote:
> > > If you can find another uid to hijack, that other uid has bad
> > > problems. And I do not think you'll commonly find another uid to
> > > hijack.
> > 
> > How about another gid, then?  Should we reset all caps on sgid exec?
> 
> Yes. Any setuid/setgid exec is a security barrier, and weird (or new)
> semantics may not cross that barrier.

Right, so what I was saying was: if you reset all regular caps on sgid
exec, anyone can trivially reset all regular caps by creating a sgid
program (users are always members of a great many groups so "finding
another gid to hijack" is trivial).  So CAP_REG_SXID needs to be off
all the time, so we lose again.

But I'll make this a securebit ("unsanitized sxid"), with the behavior
you advertise as default (0).

> > Ultimately a compromise is to be reached between security and
> > flexibility...  The problem is, I don't know who should make the
> > decision.
> 
> Go for security here. (Normally, consensus on the list is needed for
> merging the patch).

I am now completely convinced the patch will never be merged. :-(
Linux will have useless caps forever...

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
