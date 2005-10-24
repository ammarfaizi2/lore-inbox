Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVJXNTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVJXNTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVJXNTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:19:01 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36279 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750989AbVJXNTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:19:00 -0400
Subject: Re: select() for delay.
From: Steven Rostedt <rostedt@goodmis.org>
To: madhu.subbaiah@wipro.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 24 Oct 2005 09:18:54 -0400
Message-Id: <1130159934.7804.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maduhu,

On Mon, 2005-10-24 at 16:25 +0530, madhu.subbaiah@wipro.com wrote:

> +                        put_user(sec, &tvp->tv_sec);
> +                        put_user(usec, &tvp->tv_usec);

I won't comment on the rest of the patch, but this part is definitely
wrong.  The pointer tvp is a user space address and once you dereference
that pointer to get to tv_sec, you can have a fault, which might
segfault the processes.

What you really want is something like:

{
	timeval tv;

	tv.tv_sec = sec;
	tv.tv_usec = usec;
	copy_to_user(tvp, &tv, sizeof(tv));
}

-- Steve


