Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbUCBSkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbUCBSkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:40:11 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:32190 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261717AbUCBSkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:40:06 -0500
Subject: [PATCH 0/3] Auto checkout for kbuild
From: Dave Dillow <dave@thedillows.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040302180730.GD2135@mars.ravnborg.org>
References: <20040229235150.GA6327@merlin.emma.line.org>
	 <20040301060859.GA2129@mars.ravnborg.org>
	 <1078163528.22900.17.camel@dillow.idleaire.com>
	 <20040302180730.GD2135@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1078252801.31314.21.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 13:40:02 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2004 18:40:05.0530 (UTC) FILETIME=[C7C2CFA0:01C40085]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 13:07, Sam Ravnborg wrote:
> I have pulled the tree, and the getfiles script and Makefile.repo is easy to spot.
> Could you drop a mail with the rest of your changes as a regular patch?

Here's three patches, in order. The first adds getfiles and
Makefile.repo. It will pull all files needed from BK, except for the
Kconfig files.

The second adds support for Kconfig files.

The third is just some comsetic cleanups to cut chatter during
non-verbose builds.

> I will then try to look through what you made - but my first impression is that this
> is by far too much overhead just to replace an "bk -r co -Sq".

There is a bit of overhead, but mainly for files that are not there. If
the file has already been checked out, and the SCCS file is not newer,
then getfiles will not be run. There is the matter of an extra stat()
call, though, to figure that out.

For me, since I am working in a NFS directory, this is much faster than
doing a "bk -r get; make bzImage" because it only pulls the files needed
to build my kernel configuration. Even on a local disk, it "feels"
faster, though I'm sure I do not see as much of a benefit.

Code wise, yeah, it is more overhead, and it could be potentially
fragile in regards to compiler messages in the getfiles script.
-- 
Dave Dillow <dave@thedillows.org>

