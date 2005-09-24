Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVIXHBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVIXHBv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVIXHBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:01:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58261 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751448AbVIXHBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:01:51 -0400
Date: Sat, 24 Sep 2005 08:01:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
Message-ID: <20050924070150.GL7992@ftp.linux.org.uk>
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org> <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu> <20050924060913.GK7992@ftp.linux.org.uk> <E1EJ3ib-0007V7-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EJ3ib-0007V7-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 08:41:05AM +0200, Miklos Szeredi wrote:
> > > Well yes.  But I don't think anybody is using it, and if so they are
> > > clearly breaking the rules in man open(2):
> > 
> > Be liberal in what you accept and all such...  Everything else aside,
> > why bother?
> 
> To conform to well defined semantics?

Well-defined is not exactly the word I'd use for that mess (example -
we still have the last remnant of ancient BSD idiocy in there; the last
case when dangling symlink is still traversed upon object creation,
everything else had been fixed since then).

And O_DIRECTORY is not the only flag that acquires or loses meaning
depending on O_CREAT - consider e.g. O_EXCL.  It's a mess, of course,
but this mess is part of userland ABI.  We tried to fix symlink idiocy,
BTW, on the assumption that nothing would be relying on it.  Didn't
work...
