Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTH1NA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTH1NA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:00:57 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:4231 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264018AbTH1NAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:00:55 -0400
Date: Thu, 28 Aug 2003 14:00:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: Timo Sirainen <tss@iki.fi>, David Schwartz <davids@webmaster.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828130043.GE6800@mail.jlokier.co.uk>
References: <20030828121823.GB6800@mail.jlokier.co.uk> <Pine.LNX.4.44.0308280556170.14580-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308280556170.14580-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> While the write had "12" in its buffers and it  would have grabbed the 
> page lock to write it into the page cache, won't it set some flag saying 
> that I don't want to be prempted now. I think there is a small primitive 
> for it in from 2.5 onwards. I don't think it will be a good idea to prempt 
> while it is holding the page lock. How is it possible that it just wrote 
> "1" and did not write "2" though it had grabbed the page lock for that 
> purpose. 

Nope.  I don't see any disabling of preemption while the page is held.

It wouldn't make sense anyway, because the copies to/from userspace
can sleep, so there's nothing to gain by disabling preemption.

-- Jamie
