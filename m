Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbUJ1EZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbUJ1EZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUJ1EZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:25:59 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:29586 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262752AbUJ1EZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:25:54 -0400
Date: Wed, 27 Oct 2004 21:25:53 -0700 (PDT)
From: Sorav Bansal <sbansal@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: BUG REPORT: User/Kernel Pointer bug in sys_poll
Message-ID: <Pine.GSO.4.44.0410272125170.22702-100000@elaine11.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Package: linux-kernel-src
Version: 2.4.27

Description: User/Kernel pointer bug/security holl in sys_poll

I think, there is a potential bug/security hole in the sys_poll system
call.

In sys_poll, the user pointer ufds (first arg to sys_poll) goes through
copy_from_user. Then __put_user is called on &ufds->revents.

Since copy_from_user is a read access and __put_user is a write access,
the first call does not verify write-access to ufds. This can be exploited
by a malicious user on a 386 machine (where write-protection in
kernel mode is not enabled .i.e. CONFIG_X86_WP_WORKS_OK is undef).

It seems that this bug can be corrected by replacing the two __put_user
calls in sys_poll by put_user. I am using the latest kernel from
kernel.org .i.e. linux-2.4.27

thanks,
Sorav

