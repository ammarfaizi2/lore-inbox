Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbUCZSh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUCZSh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:37:59 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:41937 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264121AbUCZS3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:29:47 -0500
Date: Fri, 26 Mar 2004 18:23:26 +0000
From: Dave Jones <davej@redhat.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040326182326.GM22561@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, davidm@hpl.hp.com,
	Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org
References: <20040325141923.7080c6f0.akpm@osdl.org> <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org> <20040326110619.GA25210@redhat.com> <16484.29095.842735.102236@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16484.29095.842735.102236@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 10:08:39AM -0800, David Mosberger wrote:

 > > I think this may be dangerous on some CPUs, if may prefetch
 > > past the end of the buffer. Ie, if PREFETCH_STRIDE was 32, and
 > > len was 65, we'd end up prefetching 65->97. As well as being
 > > wasteful to cachelines, this can crash if theres for eg
 > > nothing mapped after the next page boundary.
 > 
 > Huh?  It only ever prefetches addresses that are _within_ the
 > specified buffer.  Of course it will prefetch entire cachelines, but I
 > hope you're not worried about cachlines crossing page-boundaries! ;-))

The proposed only user of this may take care of this requirement, but
I'm more concerned someone not aware of this requirement using this
helper routine. At the least it deserves a comment IMO.

		Dave

