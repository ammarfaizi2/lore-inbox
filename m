Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbTJAPYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJAPYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:24:36 -0400
Received: from ns.suse.de ([195.135.220.2]:22985 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262333AbTJAPYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:24:04 -0400
Date: Wed, 1 Oct 2003 17:24:02 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, jamie@shareable.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001152401.GM22333@wotan.suse.de>
References: <20031001073132.GK1131@mail.shareable.org> <Pine.LNX.4.44.0310010900280.5501-100000@localhost.localdomain> <20031001093329.GA2649@mail.shareable.org> <20031001075151.4e595f99.akpm@osdl.org> <20031001145631.GK22333@wotan.suse.de> <20031001081910.70d4751b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001081910.70d4751b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is it not sufficient to do something like:
> 
> 	if (!(error_code & 4) && is_prefetch(...))
> 		return;
> 
> near the start of do_page_fault()?

That could fault recursively when the __get_user in is_prefetch faults. 
You would have to check the exception table first too.

-Andi
