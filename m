Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423657AbWJZTOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423657AbWJZTOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423660AbWJZTOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:14:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8123 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423657AbWJZTOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:14:49 -0400
Date: Thu, 26 Oct 2006 15:11:54 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: psusi@cfl.rr.com, Jens Axboe <jens.axboe@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061026191154.GG4978@redhat.com>
References: <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com> <453E9368.9070405@de.ibm.com> <y0mvem8thc3.fsf@ton.toronto.redhat.com> <45409709.3000701@de.ibm.com> <20061026121348.GB4978@redhat.com> <4540BA32.3020708@de.ibm.com> <20061026140218.GC4978@redhat.com> <4540D61B.5040802@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540D61B.5040802@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI -

On Thu, Oct 26, 2006 at 05:36:59PM +0200, Martin Peschke wrote:

> [...]  I meant scaling with regard to lots of different keys.  This
> is what you have described as "By 'rows'", isn't it?

Yes.

> For example, if I wanted to store a timestamp for each request
> issued, and there were lots of devices and the I/O was driving the
> system crazy - how would affect that lookup time?

If you have only hundreds or thousands of such requests on the go
at any given time, that's not a problem.  Hash by pointer.

> [...]  I would be done with that lookup table entry then.  But it
> won't go away, will it? Is this an issue?

The entry can be instantly cleared for reuse by another future
key-value pair.  Think of it like a mini slab cache.

> [...]  Anyway, I think this discussion shows that any dynamically
> added client of kernel markers which needs to hold extra data for
> entities like requests might be difficult to be implemented
> efficiently (compared to static instrumentation), because markers,
> by nature, only allow for code additions, but not for additions to
> existing data structures.

It's a question that mixes quantitative and policy matters.  It's
certainly *somewhat* slower to store data on the side, but whether in
the context of the event source that is okay or not Just Depends.  On
the flip side, patching in hard-coded extra data storage for busy
structures also has a cost if the statistics gathering is not actually
requested by the end-user.  (On the policy side, one must weigh to
what extent it's reasonable to pad more and more data structures, just
in case.)

- FChE
