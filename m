Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbUJQUTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbUJQUTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJQUTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:19:01 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:15014 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269394AbUJQUS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:18:29 -0400
Subject: Re: [patch] exec-shield-nx-2.6.9-A1
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mingo@elte.hu
Content-Type: text/plain
Organization: 
Message-Id: <1098043886.2674.14320.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 16:11:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You have some bits in this patch that don't belong.
They aren't even conditional on a config option or
sysctl value.

First, you change the permission on the /proc/*/maps file.
Normally a remote attacker is unable to read this anyway,
and a local setuid attack has time to try until success.
Changing the permission might be a good idea, mostly
because it exposes filenames, but it should be a separate
patch.

Second, you restrict wchan. Oddly, you don't allow for
the target task's euid to play a role, and you chose the
CAP_SYS_NICE bit instead of some other bit. Huh? One might
guess from CAP_SYS_NICE that the feature has now become
hopelessly slow. Same as with the maps file, this should
be a separate patch.




