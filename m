Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVHOMQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVHOMQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVHOMQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:16:11 -0400
Received: from science.horizon.com ([192.35.100.1]:41781 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751090AbVHOMQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:16:10 -0400
Date: 15 Aug 2005 08:15:55 -0400
Message-ID: <20050815121555.29159.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, is there any place *other* than write() to the page cache that
warrants a non-temporal store?  Network sockets with scatter/gather and
hardware checksum, maybe?

This is pretty much synonomous with what is allowed to go into high
memory, no?


While we're on the subject, for the copy_from_user source, prefetchnta is
probably indicated.  If user space hasn't caused it to be cached already
(admittedly, the common case), we *know* the kernel isn't going to look
at that data again.
