Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWBZOL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWBZOL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWBZOL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:11:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44756 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751006AbWBZOL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:11:26 -0500
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM
	Change?
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Marr <marr@flex.com>,
       reiserfs-dev@namesys.com
In-Reply-To: <4401B233.7050308@yahoo.com.au>
References: <200602241522.48725.marr@flex.com>
	 <20060224211650.569248d0.akpm@osdl.org>
	 <200602261407.33262.ioe-lkml@rameria.de>  <4401B233.7050308@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 15:11:20 +0100
Message-Id: <1140963081.2934.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 00:50 +1100, Nick Piggin wrote:
> 
> Not really. The app is not silly if it does an fseek() then a _write_.
> Writing page sized and aligned chunks should not require previously
> uptodate pagecache, so doing a pre-read like this is a complete waste.
> 
> Actually glibc tries to turn this pre-read off if the seek is to a page
> aligned offset, presumably to handle this case. However a big write
> would only have to RMW the first and last partial pages, so pre-reading
> 128KB in this case is wrong.
> 
> And I would also say a 4K read is wrong as well, because a big read will
> be less efficient due to the extra syscall and small IO.


I can very much see the point of issuing a sys_readahead instead.....


