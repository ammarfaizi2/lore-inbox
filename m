Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbUKTAVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUKTAVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKTARa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:17:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261793AbUKTANM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:13:12 -0500
Date: Sat, 20 Nov 2004 00:12:59 GMT
Message-Id: <200411200012.iAK0CxLw006618@sisko.sctweedie.blueyonder.co.uk>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/3]: ext3: Cleanup error handling in current 2.6 bk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Reposting, I managed to trigger a script with a truly ancient lkml address
first time around!]

The patches to follow clean up a few aspects of ext3's error handling
when it encounters corrupt data on disk.

ext3 contains a fair amount of internal debugging and assert-checking,
but a general rule is that it should never BUG() when it encounters
on-disk corruption: a BUG() is legal only when it recognises that its
own internal memory state has been compromised.  For on-disk
corruption, we use ext3_error() instead (and the user *can* request
panic-on-error when that occurs, but the default is a graceful
shutdown of that filesystem, turning it readonly.)

The patches fix two possible routes where bad data on disk could lead
to a BUG(), and cleanup the error reporting when the fs is taken
offline.
