Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTFBP0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTFBP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:26:47 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:5626 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262457AbTFBP0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:26:46 -0400
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: matsunaga <matsunaga_kazuhisa@yahoo.co.jp>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030602153656.GA679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
	 <002901c32919$ddc37000$570486da@w0a3t0>
	 <20030602153656.GA679@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1054568407.20369.382.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 02 Jun 2003 16:40:07 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 16:36, Jörn Engel wrote:
> Considering that mtdblock should not be performance critical in
> production use anyway, this is a very hard problem.  What do you
> think?

mtdblock shouldn't actually be _using_ the vmalloc'd buffer for write
caching in production at all. Anyone using mtdblock in write mode for
production wants shooting.

Perhaps we could get away with allocating it only when the device is
opened for write? Even that's suboptimal since in 2.4, JFFS2 opens the
mtdblock device for write but doesn't actually _write_ to it; just gets
the appropriate MTD device and uses that directly.

-- 
dwmw2

