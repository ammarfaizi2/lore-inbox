Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUAPFia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265274AbUAPFi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:38:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10042 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265271AbUAPFi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:38:28 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
	<1074185897.1868.118.camel@mulgrave>
	<m17jztau8l.fsf@ebiederm.dsl.xmission.com>
	<1074196460.1868.250.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jan 2004 22:32:23 -0700
In-Reply-To: <1074196460.1868.250.camel@mulgrave>
Message-ID: <m13cagbgrc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:

> On Thu, 2004-01-15 at 14:26, Eric W. Biederman wrote:
> > And end up looking like:
> > fec00000-fec00fff : reserved
> > fec01000-fec013ff : 0000:00:0f.0
> > fec01400-fec08fff : reserved
> 
> Oh, I see you're splitting an existing resource around it.

Yes, this is the extreme case.  In normal cases I would just
expect to push to one side and probably shrink it to 0.  I guess
I have something against implying a hierarchal relationship that
does not exist.
 
> So the e820 map requests reserved regions with tentative and
> insert_resource is allowed to place resources into tentative regions. 
> That works for me, but I don't see how it works for the bridge
> case...there you really want to insert the bridge resource over
> everything else.

Right.  To me it looks like separate cases.  What I keep envisioning
scanning the PCI devices and then realizing they are behind
a bridge.  Before I go to far I guess I should ask.

The splitting/pushing aside looks especially useful for those
cases where you subdivide the resource again.

As for the bridge case I think that is something different.  

Eric
