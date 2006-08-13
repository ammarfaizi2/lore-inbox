Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWHMC6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWHMC6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 22:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWHMC6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 22:58:50 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:30254 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932667AbWHMC6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 22:58:49 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: 2.6.18-rc1 make -j4 does not run parallel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Aug 2006 12:58:51 +1000
Message-ID: <3740.1155437931@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dual cpu system.
'echo $$' reports current id is 4972
export KBUILD_OUTPUT=../obj
make -j4

Building a 2.6.17.7 tree, 'LANG= pstree -pl 4972' shows multiple tasks
running in parallel.  Even here it is only running 2 instead of the 4
that I expect.

bash(4972)---make(7519)---make(7522)-+-make(7721)---make(8198)---make(8513)---sh(8565)---gcc(8566)---gcc(8572)-+-as(8574)
                                     |                                                                         `-cc1(8573)
                                     `-make(8077)---sh(8558)---gcc(8559)---gcc(8569)-+-as(8571)
                                                                                     `-cc1(8570)

build a 2.6.18-rc1 or later tree, make -j4 does not run parallel.  All
pstree output shows a single branch, like this.

bash(4972)---make(30031)---make(30034)---make(31797)---make(2840)---sh(3678)---gcc(3681)---gcc(3682)---cc1(3683)

Using 'make -j' without a number or 'make -j<n>' where <n> is greater
than 4 does show parallel build behaviour.  Looks like something is
decrementing -j<n> as you go down the make tree and decrementing it
enough that it ends up in a serial build.
