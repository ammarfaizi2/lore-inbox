Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTH1K1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTH1K1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:27:10 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:52875
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S262288AbTH1K0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:26:55 -0400
Subject: RE: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: David Schwartz <davids@webmaster.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKEEJEFLAA.davids@webmaster.com>
Content-Type: text/plain
Message-Id: <1062066411.1451.319.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 13:26:52 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 12:56, David Schwartz wrote:
> > > You said that MD5 wasn't strong enough, and you would like a guarantee.
> 
> > Yes. I don't really like it if my program heavily relies on something
> > that can go wrong in some situations.
> 
> 	Okay, this is too much. Your alternative, assuming the kernel won't
> re-order writes, is clearly relying on something that can go wrong.

Reorder on per-byte basis? Per-page/block would still be acceptable.

Anyway, the alternative would be shared mmap()ed file. You can trust
32bit memory updates to be atomic, right?

Or what about: write("12"), fsync(), write("12")? Is it still possible
for read() to return "1x1x"?


