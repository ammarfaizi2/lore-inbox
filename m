Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUEGQJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUEGQJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEGQJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:09:56 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:55051 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263663AbUEGQJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:09:50 -0400
Date: Fri, 7 May 2004 12:09:36 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Steve Lord <lord@xfs.org>, Dave Jones <davej@redhat.com>,
       Paul Jakma <paul@clubi.ie>, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <20040507160935.GC26039@fieldses.org>
References: <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com> <20040507151317.GA15823@redhat.com> <409BAFAC.70601@xfs.org> <20040507155941.GA17850@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507155941.GA17850@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 05:59:43PM +0200, Arjan van de Ven wrote:
> On Fri, May 07, 2004 at 10:47:56AM -0500, Steve Lord wrote:
> > >-	if (mlen > sizeof(buf))
> > >+	obj.data = kmalloc(1024, GFP_KERNEL);
> > >+	if (!obj.data)
> > >+		return -ENOMEM;
> > >+
> > >+	if (mlen > 1024) {
> > 
> > That's what I hate about all of this, just think how much stack that
> > kmalloc can take in low memory situations.... it might end up in
> > writepage on another nfs file....
> 
> it clearly needs to be GFP_NOFS

The function is question is essentially a write method for a virtual
filesystem (rpc_pipefs) that's used to communicate with some
NFSv4-related daemons.  It isn't called from any of the NFS fileystem
code.

--Bruce Fields
