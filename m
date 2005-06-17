Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVFQSqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVFQSqP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVFQSqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:46:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57766 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262054AbVFQSp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:45:58 -0400
Date: Fri, 17 Jun 2005 19:45:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
Message-ID: <20050617184550.GA20822@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, Arnd Bergmann <arnd@arndb.de>,
	Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Andrew Morton <akpm@osdl.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de> <20050617175404.GA19463@infradead.org> <1119032213.3949.124.camel@betsy> <20050617182826.GA20250@infradead.org> <1119033486.3949.135.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119033486.3949.135.camel@betsy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 02:38:06PM -0400, Robert Love wrote:
> > You are using ioctl as an really bad syscall multiplexer.  You're
> > not using the file descriptor it's called on at all, so it does not qualify
> > as a valid ioctl() usage even under the most lax rules.
> 
> We provide two different ioctl commands, it is not a bad multiplexer.
> We have discussed this before.
> 
> We do use the fd.  It maps back to the inotify device.

inotify does indeed use file->private data to retrieve the inotify_dev
structure.  Of which by design exists a single instance only.  So yes,
you do not use the file descriptor at all.

This really looks like copied from the ioctl abuse 101 example code.
We are beating up driver writers for stupidities like that all the time,
and inotify is not going to get a special treatment just because it's
core code.

> > Also you claimed the resource shortage for the proposed architecture
> > with just a single syscall, aka one watch per fd without showing any
> > reasons why that would be true, in fact by any means there's no reason
> > to believe file descriptors are a rare ressource in a modern Linux system.
> 
> It is not implausible to believe that a system might have the default
> maximum for file descriptors (not very high) but allow a _much_ greater
> number of inotify watches (32k, say).

And a default limit matters exactly how?

> Everything to you is "really bad" and "totally unacceptable".  Chill
> out.  Stop ranting so much and enjoy life.

Thanks a lot, I'm enjoying life a lot when I don't happen to have to deal
with ignorant people :)

