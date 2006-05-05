Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWEEQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWEEQgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEEQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:36:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:46821 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751161AbWEEQgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:36:05 -0400
Message-ID: <445B7EF0.6090708@zytor.com>
Date: Fri, 05 May 2006 09:36:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for the AMD FXSAVE information leak had a problematic side effect.  It 
introduced an entry in the x86 features vector which is a bug, not a feature.

The problem with this is that the features vector is designed so that it can be ANDed 
between CPUs to find out the common feature set.  However, bugs aren't features, and bugs 
should be ORd, not ANDed.  In that sense, the *absence* of a bug is a feature.

There are two possible ways of dealing with this:

a) put bugs in the features vector, but sense-inversed, i.e. 1 = bug absent; 0 = bug present.

b) add a separate bugs vector.

When I originally wrote the code I always meant to do (b), but never got around to it. 
It's clear, though, that whatever way we go about this, it should also incorporate the 
fdiv, hlt, f00f, and coma bugs.

	-hpa
