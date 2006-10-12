Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWJLMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWJLMHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWJLMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:07:37 -0400
Received: from ns.suse.de ([195.135.220.2]:6316 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750985AbWJLMHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:07:37 -0400
Date: Thu, 12 Oct 2006 14:07:35 +0200
From: Nick Piggin <npiggin@suse.de>
To: Carsten Otte <cotte.de@gmail.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061012120735.GA20191@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <5c77e7070610120456t1bdaa95cre611080c9c953582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c77e7070610120456t1bdaa95cre611080c9c953582@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 01:56:38PM +0200, Carsten Otte wrote:
> As for the filemap_xip changes, looks nice as far as I can tell. I will test
> that change for xip.

Actually, filemap_xip needs some attention I think... if xip files
can be truncated or invalidated (I assume they can), then we need to
lock the page, validate that it is the correct one and not truncated,
and return with it locked.

That should be as simple as just locking the page and rechecking i_size,
but maybe the zero page can be handled better... I don't know?


