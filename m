Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVIKW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVIKW4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVIKW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:56:40 -0400
Received: from xenotime.net ([66.160.160.81]:25264 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751005AbVIKW4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:56:40 -0400
Date: Sun, 11 Sep 2005 15:56:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] [PATCH] make add_taint() inline
Message-Id: <20050911155637.3839db5c.rdunlap@xenotime.net>
In-Reply-To: <8244F3CF-9EF7-44BB-B3DA-B46A1FF39E1C@mac.com>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net>
	<20050911104437.6445ff20.donate@madrone.org>
	<8244F3CF-9EF7-44BB-B3DA-B46A1FF39E1C@mac.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005 14:22:08 -0400 Kyle Moffett wrote:

> On Sep 11, 2005, at 13:44:37, donate wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > add_taint() is a trivial function.
> > No need to call it out-of-line, just make it inline and
> > remove its export.
> 
> Actually, in this case it might be better to leave add_taint
> exported, add and export a new function get_taint(), and then
> remove all export of the variable "tainted".  I've actually
> seen one case where some module removed taint bits.  I don't

some in-tree module?

> remember where or why, but it seemed really bad at the time,
> and still does.  Also, does the tainted variable need any
> kind of locking?  What happens if two CPUs try to taint the
> kernel simultaneously?

Good question.  one wins?

It sure looks like a problem in theory.  I don't know that
we have ever seen a bug report related to it though.

Maybe Dave Jones's modprobe/insmod killer test on a big
multiprocessor system could do that one day.

---
~Randy
