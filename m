Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266923AbUFZC1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266923AbUFZC1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 22:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbUFZC1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 22:27:14 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:64708 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266923AbUFZC05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 22:26:57 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] teach netconsole how to do syslog 
In-reply-to: Your message of "Fri, 25 Jun 2004 14:11:01 EST."
             <20040625191101.GD25826@waste.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Jun 2004 12:26:46 +1000
Message-ID: <25929.1088216806@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004 14:11:01 -0500, 
Matt Mackall <mpm@selenic.com> wrote:
>Yep, we get one UDP packet per printk currently, which works for most
>things, but not everything. This could be changed to a buffered
>approach, but that breaks one of my favorite debugging techniques -
>adding an alphabet soup of single-character printks to trace tricky
>call paths. 
>
>So we could add a __printk that doesn't flush to outputs for stuff
>like the above, or just live with it.

Other way round.  Keep printk as is and use a buffered approach for
printk over netconsole.  netconsole gets complete lines which is what
you want 99.9% of the time.  Add __printk or printk_unbuffered for the
.1% of debugging output that really wants unbuffered output.

