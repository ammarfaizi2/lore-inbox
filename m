Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUIOXAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUIOXAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUIOW4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:56:45 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:8166 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267748AbUIOWxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:53:42 -0400
Subject: get_current is __pure__, maybe __const__ even
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ak@muc.de
Content-Type: text/plain
Organization: 
Message-Id: <1095288600.1174.5968.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Sep 2004 18:50:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> Please CSE "current" manually. It generates
> much better code on some architectures
> because the compiler cannot do it for you.

This looks fixable.

At the very least, __attribute__((__pure__))
will apply to your get_current function.

I think __attribute__((__const__)) will too,
even though it's technically against the
documentation. While you do indeed read from
memory, you don't read from memory that could
be seen as changing. Nothing done during the
lifetime of a task will change "current" as
viewed from within that task.


