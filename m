Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935672AbWK1Gn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935672AbWK1Gn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935671AbWK1Gn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:43:28 -0500
Received: from fire.yars.free.net ([193.233.48.99]:15515 "EHLO fire.netis.ru")
	by vger.kernel.org with ESMTP id S935673AbWK1Gn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:43:27 -0500
Date: Tue, 28 Nov 2006 09:42:36 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6.18: memory leak(?)
Message-ID: <20061128064236.GA19797@night.netis.ru>
References: <20061127124443.GA11569@night.netis.ru> <20061127193834.b5ca80db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127193834.b5ca80db.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-NETIS-MailScanner-Information: Please contact NETIS Telecom for more information <info@netis.ru> (+7 0852 797709)
X-NETIS-MailScanner: Found to be clean
X-NETIS-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 6, autolearn=disabled, ALL_TRUSTED -1.00)
X-NETIS-MailScanner-From: lav@netis.ru
X-NETIS-MailScanner-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 07:38:34PM -0800, Andrew Morton wrote:
> It's not necessarily a leak.  Networking tried to allocate two

You are right, it is not a leak. Probably the memory usage increased for some
other reason.

> physically-contiguous pages from atomic context, but no such two pages were
> available.  The packet will be dropped and things should recover.
> 
> Increasing /proc/sys/vm/min_free_kbytes will reduce the frequency somewhat.
> If it's actually a problem, which I doubt?

It is a problem. The messages load syslog and thus disk, network performance
decreases due to lost packets. I'll try to increase min_free_kbytes and
see if it helps.

-- 
   Alexander.
