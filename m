Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVITKHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVITKHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVITKHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:07:22 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:45829 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964956AbVITKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:07:21 -0400
To: trond.myklebust@fys.uio.no
CC: smfrench@austin.rr.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <E1EHdrk-00014N-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 20 Sep 2005 10:52:40 +0200)
Subject: Re: ctime set by truncate even if NOCMTIME requested
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
	 <1127165311.8519.39.camel@lade.trondhjem.org>
	 <432F5968.1020106@austin.rr.com> <1127180199.26459.17.camel@lade.trondhjem.org> <E1EHdrk-00014N-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1EHf0E-000197-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Sep 2005 12:05:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > However if you know the cases where time is set implicitly by the
> > server, why can't you simply optimise away the ATTR_CTIME and/or
> > ATTR_MTIME?
> 
> How?  By checking whether ATTR_SIZE is also set?  Yes, that would work
> for truncate(), but it's rather more ugly than the proposed check for
> IS_NOCMTIME.

I have to correct myself: it seems, the check is not needed.  Ctime is
never set explicitly.  So filesystem can simply ignore ATTR_CTIME, and
do the right thing without it.

ATTR_MTIME is _only_ set in utime[s], which all filesystems want to
honor.

So I think the only thing CIFS needs is simply to ignore ATTR_CTIME.

Miklos
