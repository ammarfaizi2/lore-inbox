Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVAGCkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVAGCkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVAGCkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:40:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46271 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261186AbVAGCjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:39:44 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
In-Reply-To: <20050106162928.650e9d71.akpm@osdl.org>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org>
	 <20050106234123.GA27869@infradead.org>
	 <20050106162928.650e9d71.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105055333.17166.304.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 01:34:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 00:29, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> Fine.  Completely agree.  Sometimes people do need to be forced to make
> such changes - I don't think anyone would disagree with that.
> 
> What's under discussion here is "how to do it".  Do we just remove things
> when we notice them, or do we give (say) 12 months notice?

Why should we keep junk around for 12 months that nobody has a legal
reason to be using ? We broke every out of serial tty driver in 2.6.9
and in 2.6.10 for example and we will break them all again in ways we
can't keep the old stuff around. (and Linus broke them all in 2.6.10 8))

There is a difference between a public API like inter_module_get() and
an internal deep reference to something that is fairly private. Zapping
those kind of functions is very different and I agree we should
deprecate them properly.

A lot of this is coming up because old exports for private use were
never really properly marked as _GPL or in other ways so we have a
legacy of assumptions to tidy.

Alan

