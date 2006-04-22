Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDVUJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDVUJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDVUJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:09:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16584 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751131AbWDVUJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:09:37 -0400
Date: 22 Apr 2006 08:05:51 -0400
Message-ID: <20060422120551.27644.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: kfree(NULL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, we'd have to start by fixing up the janitors that run around
> taking out the if statements in the callers.  :)

You just need to document those two as special.  Probably the
simplest is to tell the programmer and the compiler in one
fell swoop:

	if (unlikely(p))
		kfree(p);

Or that could be wrapped up in a macro:

#define kfree_likely_null(p) if (unlikely(p)) kfree(p)

Or just mention it to the programmer.  A few possible one-line comments:

	/* Testing before calling is faster if often NULL, as here. */
	/* It's worth the (redundant) test for NULL if it often succeeds */
	/* This test saves the call often enough to be worth it. */
	/* Test for NULL not necessary, but worth it here */
	/* Don't delete NULL test; speed trumps code size here */
	/* Very often NULL, so avoid call overhead if possible */
	/* kfree(NULL) is legal, but probabilities favor testing here */
