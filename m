Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264700AbUD2VUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbUD2VUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUD2VRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:17:37 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:36757 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264966AbUD2VRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:17:19 -0400
Subject: Re: Possible permissions bug on NFSv3 kernel client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1BJISs-0000MM-W0@localhost>
References: <1QhAA-5zc-13@gated-at.bofh.it> <1QnPD-2pg-1@gated-at.bofh.it>
	 <E1BJISs-0000MM-W0@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083273435.3686.85.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 17:17:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 16:49, Pascal Schmidt wrote:
> On Thu, 29 Apr 2004 19:50:06 +0200, you wrote in linux.kernel:
> 
> >> ...so that the the MODIFY and EXTEND bits aren't set when writing to a
> >> block or character device.
> >
> > Hmm... Why shouldn't the MODIFY bit at least be set if the user
> > requested write access to the device?
> 
> It's somewhat of a mixed-up situation for device nodes exported via
> NFSv3. Permission bits are on the server, but the actual write does
> not happen via NFS (as v3 WRITE only works on regular files).

It's not "mixed up" at all: the permissions checking has to be done by
the server, period.
All the file security information (the mode bits, owner uid, group gid,
ACLs etc) that determine whether or not the open() should succeed are
defined on the *server* not on the client. If the former is doing some
form of mapping of those values (in particular if it is doing some form
of root/uid/gid squashing) then the only way for the client to get it
right is to make an ACCESS call.

The fact that the subsequent writes go to a device on the client is
entirely irrelevant.

Cheers,
  Trond
