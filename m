Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTFLXRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265055AbTFLXO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:14:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11257 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265052AbTFLXN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:13:56 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Robert Love <rml@tech9.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306121624470.11379-100000@cherise>
References: <Pine.LNX.4.44.0306121624470.11379-100000@cherise>
Content-Type: text/plain
Message-Id: <1055460564.662.339.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jun 2003 16:29:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 16:25, Patrick Mochel wrote:

> Yeah, how about this ammended patch? 

Both this and Greg's look fine.

I guess this is preferred, since the lock hold time is shorter :)

> +	spin_lock(&sequence_lock);
> +	seq = sequence_num++;
> +	spin_unlock(&sequence_lock);
> +
> +	envp [i++] = scratch;
> +	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;

Nice thinking. It is a shame we need a lock for this, but we don't have
an atomic_inc_and_return().

	Robert Love

