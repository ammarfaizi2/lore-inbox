Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWAXHI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWAXHI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWAXHI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:08:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964970AbWAXHI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:08:27 -0500
Subject: Re: [PATCH/RFC] Shared page tables
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       Dave McCracken <dmccr@us.ibm.com>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <200601240238.29781.ak@suse.de>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
	 <200601240210.04337.ak@suse.de> <20060124012331.GK1008@kvack.org>
	 <200601240238.29781.ak@suse.de>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 08:08:16 +0100
Message-Id: <1138086496.2977.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 02:38 +0100, Andi Kleen wrote:
> On Tuesday 24 January 2006 02:23, Benjamin LaHaise wrote:
> > On Tue, Jan 24, 2006 at 02:10:03AM +0100, Andi Kleen wrote:
> > > The randomization is not for cache coloring, but for security purposes
> > > (except for the old very small stack randomization that was used
> > > to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
> > > mmap made much difference because it's page aligned and at least
> > > on x86 the L2 and larger caches are usually PI.
> > 
> > Actually, does this even affect executable segments?  Iirc, prelinking 
> > already results in executables being mapped at the same physical offset 
> > across binaries in a given system.  An strace seems to confirm that.
> 
> Shared libraries should be affected. And prelink is not always used.

without prelink you have almost no sharing of the exact same locations,
since each binary will link to different libs and in different orders,
so any sharing you get is purely an accident (with glibc being maybe an
exception since everything will link that first). This
sharing-of-code-pagetables seems to really depend on prelink to work
well, regardless of randomization

