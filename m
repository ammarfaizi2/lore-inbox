Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUKNL0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUKNL0R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 06:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUKNL0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 06:26:17 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:1554 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261286AbUKNL0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 06:26:14 -0500
Date: Sun, 14 Nov 2004 12:26:10 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Patrick McHardy <kaber@trash.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
Message-ID: <20041114112610.GB8680@pclin040.win.tue.nl>
References: <20041114013724.GA21219@apps.cwi.nl> <41970FAD.6010501@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41970FAD.6010501@trash.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 08:56:29AM +0100, Patrick McHardy wrote:
> Andries Brouwer wrote:
> 
> >Stuff marked initdata that is referenced in non-init context.
>
> Where ? The initial tables are replaced by ipt_register_table.

ip_nat_rule.c:nat_initial_table was referenced in

static struct ipt_table nat_table = {
        .table          = &nat_initial_table.repl,
	...

iptable_filter.c:initial_table was referenced in

static struct ipt_table packet_filter = {
        .table          = &initial_table.repl,
	...

This is not to say that there is a bug here, that the .init
data would actually be referenced by non-init stuff, but
it is better to convince oneself by static inspection of
the binary than by reasoning about the flow of the program.

Where the memory savings are important, the code should
be rewritten a bit.

Andries

