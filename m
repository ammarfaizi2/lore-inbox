Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHaRJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHaRJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUHaRJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:09:31 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62468 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264917AbUHaRBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:01:45 -0400
Date: Tue, 31 Aug 2004 18:01:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DRM initial function table support.
Message-ID: <20040831180129.A23112@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ian Romanick <idr@us.ibm.com>, Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408311409530.18657@skynet> <20040831152015.GC22978@redhat.com> <4134A22F.7000103@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4134A22F.7000103@us.ibm.com>; from idr@us.ibm.com on Tue, Aug 31, 2004 at 09:07:11AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 09:07:11AM -0700, Ian Romanick wrote:
> I think the intention is to have default functions set in the 
> device-independent code and have the device-dependent code over-ride 
> them.  Since the defaults may not always be NULL, doing a struct like 
> that wouldn't really work.  I suppose we could have a struct and a 
> device-independent function that copies the non-NULL pointers from the 
> per-device struct.  Would that be better?

Don't copy them.  Just put

if (foo->ops->method1)
	foo->ops->method1(args);
else
	generic_method1(args);

in your code.  It's an additional branch, but you avoid the indirect
functioncalloverhead in exchange.
