Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUHQWQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUHQWQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268484AbUHQWQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:16:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268479AbUHQWQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:16:19 -0400
Date: Tue, 17 Aug 2004 18:15:25 -0400
From: Alan Cox <alan@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Message-ID: <20040817221525.GA29340@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170231.25725.bzolnier@elka.pw.edu.pl> <20040817010533.GB32628@devserv.devel.redhat.com> <200408171248.12235.bzolnier@elka.pw.edu.pl> <20040817120622.GF3204@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817120622.GF3204@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 08:06:22AM -0400, Alan Cox wrote:
> I'll have a look at what occurs if we make the ->key functions ref count
> and add "put" functions. I think that can be made to work cleanly without
> changing the rest of the code to refcounts at the same time. It'll still need
> some locking because of the memset.  We would still have keys but we'd
> refcount usage off them as a starting point.

Ok fixed this by using the cfg_sem. refcounting breaks the non refcounted
code and its assumptions (good bad or otherwise). I've dropped the locking
in in such a way as switching to refcounts later is easier.

Alan

