Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbVCECWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbVCECWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbVCEAg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:36:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:41669 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263491AbVCEAb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:31:56 -0500
Date: Fri, 4 Mar 2005 16:31:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: pbadari@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
Message-Id: <20050304163153.62afd2f1.akpm@osdl.org>
In-Reply-To: <20050304162331.4a7dfdb8.akpm@osdl.org>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
	<20050304162331.4a7dfdb8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> page reclaim can come in, grab the page lock and
> whip the page off the mapping.

No it can't - we hold an additional ref on the page, so reclaim will back
off.  Still, it feels a bit flakey.

And we're not supposed to take lock_page() inside journal_start, because
that's a ranking violation.  Probably i_sem will prevent an actual deadlock
occurring, however.
