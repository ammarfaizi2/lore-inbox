Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270281AbUJTBzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270281AbUJTBzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270246AbUJTBvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:51:04 -0400
Received: from almesberger.net ([63.105.73.238]:36621 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S266465AbUJTBrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:47:37 -0400
Date: Tue, 19 Oct 2004 22:47:32 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boot parameters: quoting of environment variables revisited
Message-ID: <20041019224732.P18873@almesberger.net>
References: <20041019192336.K18873@almesberger.net> <20041019180440.1ff780c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019180440.1ff780c5.akpm@osdl.org>; from akpm@osdl.org on Tue, Oct 19, 2004 at 06:04:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> hm.  The environment string handling and the "command line" string handling
> appear to be identical in there.  How come only one of them has the
> problem?  That function makes my eyes bleed.

The joy of "clever" string manipulation, I suppose :-(

The difference between the two branches is that the "command line"
thing uses only the parameter name, which cannot be quoted (well,
at least kernel/params.c doesn't let this happen). So the whole
problem can't occur.

If you quote the parameter name, the quotes will happily end up
in the argument, thanks to kernel/params.c.

Perhaps a better long-term solution would be to fix all this in
kernel/params.c, and remove any quote special-casing from
init/main.c. It just scares me to touch such a highly sensitive
area of the kernel ... :)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
