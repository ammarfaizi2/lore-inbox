Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272748AbTHKPub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272772AbTHKPub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:50:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63759 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272748AbTHKPuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:50:25 -0400
Date: Mon, 11 Aug 2003 17:50:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Warnings building 2.4.22rc2 with gcc 3.3
Message-ID: <20030811155023.GB2868@alpha.home.local>
References: <20030811085453.71881.qmail@web40509.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811085453.71881.qmail@web40509.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:54:53AM -0700, Alex Davis wrote:
> When I build 2.4.22rc2 with gcc 3.3, I get the following warnings
> 
> 
> vt.c:166: warning: comparison is always false due to limited range of data type
> vt.c:283: warning: comparison is always false due to limited range of data type
> keyboard.c:644: warning: comparison is always true due to limited range of data type
> 
> It seems an unsigned char is being compared with 256, which always returns false.

For keyboard.c, the test is :

        if (value < SIZE(func_table)) {

so it's reassuring that any value is contained in the table. We could hide
the warning with a cast of value to (int).

for vt.c, it's the same concept, some bounds are enforced on some values, and
in the event they would be violated, -EINVAL would be returned. So the check,
even if useless here, has some sense. Here again, a cast could hide the
warnings, but may generate useless code.

Cheers,
Willy

