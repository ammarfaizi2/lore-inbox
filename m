Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTKLPgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTKLPgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:36:45 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:31734 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262202AbTKLPgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:36:44 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Florian Weimer <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Wed, 12 Nov 2003 09:36:00 -0600
X-Mailer: KMail [version 1.2]
References: <1068512710.722.161.camel@cube> <20031110230055.S10197@schatzie.adilger.int> <20031111085806.GC11435@deneb.enyo.de>
In-Reply-To: <20031111085806.GC11435@deneb.enyo.de>
MIME-Version: 1.0
Message-Id: <03111209360001.11900@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 November 2003 02:58, Florian Weimer wrote:
> Andreas Dilger wrote:
> > > This is fast turning into a creeping horror of aggregation.  I defy
> > > anybody to create an API to cover all the options mentioned so far and
> > > *not* have it look like the process_clone horror we so roundly derided
> > > a few weeks ago.
> >
> > 	int sys_copy(int fd_src, int fd_dst)
>
> Doesn't work.  You have to set the security attributes while you open
> fd_dst.

Why? the open for fd_src should have the security attributes (both locally
and in the file server if networked). Opening fd_dst should SET the security
attributes desired (again, locally and in the target fileserver).

Then the sys_copy(fd_src,fd_dst) can take place in the FS code. And of course
it is necessary that fd_src and fd_dst reside on the same device. If they 
don't, then the sys_copy should fail.

If the sys_copy is a remote filesystem then fd_src, and fd_dst must be 
replaced by the remote file handles and this passed to the remote server.
Any additional checks may then be made from the evaluation of the file handles
locally on the file server, using the security credentials belonging to the
file handles.
