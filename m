Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269215AbUHaWBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269215AbUHaWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUHaWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:00:25 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3262 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269171AbUHaV7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:59:05 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040831145643.08fdf612.akpm@osdl.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 17:58:32 -0400
Message-Id: <1093989513.4815.45.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 14:56 -0700, Andrew Morton wrote:
> Robert Love <rml@ximian.com> wrote:
> >
> > +	len = strlen(object) + 1 + strlen(signal);
> > +
> > +	skb = alloc_skb(len, gfp_mask);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	buffer = skb_put(skb, len);
> > +
> > +	sprintf(buffer, "%s\n%s", object, signal);
> 
> Buffer overrun, methinks.

Hrm, but len is the right size...

Oh, missing the NULL, eh?

So

	- 	len = strlen(object) + 1 + strlen(signal);
	+ 	len = strlen(object) + 1 + strlen(signal) + 1;

should fix it, right?

	Robert Love


