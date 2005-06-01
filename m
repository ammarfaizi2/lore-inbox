Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFAHsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFAHsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFAHsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:48:22 -0400
Received: from one.firstfloor.org ([213.235.205.2]:10133 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261320AbVFAHsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:48:19 -0400
To: michael@optusnet.com.au
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
References: <20050530181626.GA10212@kvack.org> <20050530193225.GC25794@muc.de>
	<200505311137.00011.vda@ilport.com.ua>
	<200505311215.06495.vda@ilport.com.ua> <20050531092358.GA9372@muc.de>
	<m2zmuaee2z.fsf@mo.optusnet.com.au>
From: Andi Kleen <ak@muc.de>
Date: Wed, 01 Jun 2005 09:48:17 +0200
In-Reply-To: <m2zmuaee2z.fsf@mo.optusnet.com.au> (michael@optusnet.com.au's
 message of "01 Jun 2005 17:22:28 +1000")
Message-ID: <m1br6qwm9q.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

michael@optusnet.com.au writes:
>
> Key point: "using it". This normally involves writes to memory. Most
> applications don't commonly read memory that they haven't previously
> written to. (valgrind et al call that behaviour a "bug" :).
>
> Given that, I'd say you really don't want the page zero routines
> touching the cache.

Writing on a modern CPU requires reading first too to get the rest
of the cache line (provided you don't use write combing or uncached
accesses)

-Andi
