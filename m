Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVDMUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDMUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDMUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:52:56 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:38867 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261194AbVDMUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:52:55 -0400
Date: Wed, 13 Apr 2005 13:52:53 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Further copy_from_user() discussion.
Message-ID: <Pine.LNX.4.58.0504131342530.14888@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Interested by the recent discussions concerning the copy_from_user()
function, I browsed the 2.6.11.7 kernel source, and came up with a few
questions.

1. Is there any particular reason why __copy_from_user_ll() is currently
EXPORT_SYMBOL()ed for i386? At least none of the in-tree modules
currently seem to use it, and __copy_from_user() seems like what most
would want anyway. If __copy_from_user_ll() is unexported, it looks like
we can eliminate the BUG_ON() statement within it.

2. Would it be possible to eliminate the might_sleep() call in
copy_from_user()? It seems that, very soon after, the __copy_from_user()
macro does another might_sleep(), with very few instructions in between.
But there might be some trick here that I'm missing.

Please enlighten. :-)

-Vadim Lobanov
