Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWH2E7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWH2E7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWH2E7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:59:55 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:44467 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750922AbWH2E7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:59:54 -0400
Date: Tue, 29 Aug 2006 13:59:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, nitingupta.mail@gmail.com
Subject: Re: Reiser4 und LZO compression
Message-ID: <20060829045937.GA9181@localhost.hsdv.com>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com> <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156801705.2969.6.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 07:48:25AM +1000, Nigel Cunningham wrote:
> For Suspend2, we ended up converting the LZF support to a cryptoapi
> plugin. Is there any chance that you could use cryptoapi modules? We
> could then have a hope of sharing the support.
> 
Using cryptoapi plugins for the compression methods is an interesting
approach, there's a few other places in the kernel that could probably
benefit from this as well, such as jffs2 (which at the moment rolls its
own compression subsystem), and the out-of-tree page and swap cache
compression work.

Assuming you were wrapping in to LZF directly prior to the cryptoapi
integration, do you happen to have before and after numbers to determine
how heavyweight the rest of the cryptoapi overhead is? It would be
interesting to profile this and consider migrating the in-tree users,
rather than duplicating the compress/decompress routines all over the
place.
