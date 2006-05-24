Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWEXR7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWEXR7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEXR7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:59:52 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:44474 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751043AbWEXR7w (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:59:52 -0400
Message-ID: <44749F19.1020705@namesys.com>
Date: Wed, 24 May 2006 10:59:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Vier <tmv@comcast.net>
CC: Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing
 more than 4k at a time (has implications for generic write code and eventually
 for the IO layer)
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
In-Reply-To: <20060524175312.GA3579@zero>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should add, you execute a lot more than 4k worth of instructions for
each of these 4k writes, thus performance is non-optimal.  This is why
bios exist in the kernel, because the io layer has a similar problem
when you send it only 4k at a time (of executing a lot more than 4k of
instructions per io submission).The way the io layer handles bios is not
as clean as it could be though, Nate can say more on that.
