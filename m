Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTFWLbz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFWLbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:31:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13818 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261846AbTFWLbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:31:12 -0400
Date: Mon, 23 Jun 2003 12:46:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <torvalds@transmeta.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [BK PATCH] acpismp=force fix
In-Reply-To: <1056355301.1699.6.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0306231224590.1648-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, Arjan van de Ven wrote:
> On Mon, 2003-06-23 at 09:43, Grover, Andrew wrote:
> > > From: Andrew Morton [mailto:akpm@digeo.com] 
> > > >    ACPI: make it so acpismp=force works (reported by Andrew Morton)
> > 
> > > But prior to 2.5.72, CPU enumeration worked fine without 
> > > acpismp=force. 
> > > Now it is required.  How come?
> > 
> > (I'm taking the liberty to update the subject, which I accidentally left
> > blank)
> > 
> > Because 2.4 has that behavior. One objection that people raised to
> > applying the 2.4 ACPI patch was that it changed that behavior. So I made
> > an effort to keep it there.
> 
> in 2.4 it is absolutely not mantadory; it's default actually if the cpu
> advertises the "ht" flag.....

Right, enabling HT hasn't relied on "acpismp=force" since 2.4.18.
Requiring "acpismp=force" now in 2.4 or 2.5 is just a step backwards.

But when we changed to HT by default, I added bootparam "noht" to
disable it if it was found troublesome.  Last time I checked, "noht"
was ineffectual on 2.5, and perhaps now it's ineffectual on 2.4.22-pre?

(If I remember right, in 2.5 it did have one effect, determining whether
the "ht" flag is shown in /proc/cpuinfo: but it was intended to be more
useful than that.)

Certainly reliance on "acpismp=force" should be removed if it's crept
back in.  But what should we do about "noht"?  Wave a fond goodbye,
and remove it's associated code and Documentation from 2.4 and 2.5
trees, rely on changing the BIOS setting instead?  Or bring it back
into action?

Hugh

