Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCTGXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCTGXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCTGXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:23:16 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:43237 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261559AbVCTGXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:23:12 -0500
Subject: Re: [PATCH][0/6] Change proc file permissions with sysctls
From: Albert Cahalan <albert@users.sf.net>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
References: <1111278162.22BA.5209@neapel230.server4you.de>
Content-Type: text/plain
Date: Sun, 20 Mar 2005 01:08:23 -0500
Message-Id: <1111298903.1930.99.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-20 at 01:22 +0100, Rene Scharfe wrote:

> The permissions of files in /proc/1 (usually belonging to init) are
> kept as they are.  The idea is to let system processes be freely
> visible by anyone, just as before.  Especially interesting in this
> regard would be instances of login.  I don't know how to easily
> discriminate between system processes and "normal" processes inside
> the kernel (apart from pid == 1 and uid == 0 (which is too broad)).
> Any ideas?

The ideal would be to allow viewing:

1. killable processes (that is, YOU can kill them)
2. processes sharing a tty with a killable process

Optionally, add:

3. processes controlling a tty master of a killable process
4. ancestors of all of the above
5. children of killable processes

This is of course expensive, but maybe you can get some of
it cheaply. For example, allow viewing a process if the session
leader, group leader, parent, or tpgid process is killable.


