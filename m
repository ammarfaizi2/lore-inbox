Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVILVgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVILVgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVILVgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:36:17 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:15561 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932276AbVILVgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:36:15 -0400
Date: Mon, 12 Sep 2005 17:36:04 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Valdis.Kletnieks@vt.edu, Hugh Dickins <hugh@veritas.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?iso-8859-1?Q?M=E1rcio?= Oliveira 
	<moliveira@latinsourcetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output
Message-ID: <20050912213604.GC8127@fieldses.org>
References: <200509122016.j8CKGjmY029390@turing-police.cc.vt.edu> <200509122127.j8CLR3n7025719@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509122127.j8CLR3n7025719@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.10i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 05:27:03PM -0400, Horst von Brand wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > Somebody had an automated log-parsing tool, and wanted to make sure there
> > were guaranteed at least 2 non-whitespace tokens on the line so they wouldn't
> > have to deal with parsing 'Tainted:       \n'?
> 
> That's a lame excuse for messing up the kernel and mistifying the heck out
> of users. Either "Tainted: <some gunk>" or "Not tainted" (or just nothing)?

That's precisely what is does.  It's just that when there's taint other
than proprietary-module taint, it puts a "G" in that column instead of a
blank.  Which is oddly inconsistent, but whatever.

--b.

const char *print_tainted(void)
{
	static char buf[20];
	if (tainted) {
		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
			tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
			tainted & TAINT_FORCED_RMMOD ? 'R' : ' ',
 			tainted & TAINT_MACHINE_CHECK ? 'M' : ' ',
			tainted & TAINT_BAD_PAGE ? 'B' : ' ');
	}
	else
		snprintf(buf, sizeof(buf), "Not tainted");
	return(buf);
}
