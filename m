Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVBPWu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVBPWu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBPWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:50:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:24014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbVBPWuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:50:51 -0500
Date: Wed, 16 Feb 2005 14:55:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dale Blount <linux-kernel@dale.us>
Cc: Ralf.Hildebrandt@charite.de, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-Id: <20050216145548.53f67fec.akpm@osdl.org>
In-Reply-To: <1108590885.17089.17.camel@dale.velocity.net>
References: <20050215145618.GP24211@charite.de>
	<20050216153338.GA26953@atrey.karlin.mff.cuni.cz>
	<20050216200441.GH19871@charite.de>
	<1108590885.17089.17.camel@dale.velocity.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Blount <linux-kernel@dale.us> wrote:
>
> This looks very similar (at least to me) to an OOPS I posted with 2.6.9
> on 12/03/2004.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110210705504716&w=2

There have been a handful of reports - there's surely a race in there.

Unfortunately I've yet to see a report from which we can identify the
offending line in the very large journal_commit_transaction() function.

The best way to do that is to ensure that the kernel was built with
CONFIG_DEBUG_INFO, note the offending EIP value, then do

# gdb vmlinux
(gdb) l *0xc0<whatever>
