Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423350AbWJZMOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423350AbWJZMOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423352AbWJZMOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:14:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423350AbWJZMOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:14:48 -0400
Date: Thu, 26 Oct 2006 08:13:48 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Phillip Susi <psusi@cfl.rr.com>,
       Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061026121348.GB4978@redhat.com>
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com> <453E9368.9070405@de.ibm.com> <y0mvem8thc3.fsf@ton.toronto.redhat.com> <45409709.3000701@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45409709.3000701@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Thu, Oct 26, 2006 at 01:07:53PM +0200, Martin Peschke wrote:
> [...]
> I suppose the marker approach will be adopted if jumping from a
> marker to code hooked up there can be made fast and secure enough
> for prominent architectures.

Agree, and I think we're not far.  By "secure" you mean "robust"
right?

> [...]
> Dynamic instrumentation based on markers allows to grow code,
> but it doesn't allow to grow data structure, AFAICS.
>
> Statistics might require temporary results to be stored per
> entity.

The data can be kept in data structures private to the instrumentation
module.  Instead of growing the base structure, you have a lookup
table indexed by a key of the base structure.  In the lookup table,
you store whatever you would need: timestamps, whatnot.

> The workaround would be to pass any intermediate result in the form
> of a trace event up to user space and try to sort it out later -
> which takes us back to the blktrace approach.

In systemtap, it is routine to store such intermediate data in kernel
space, and process it into aggregate statistics on demand, still in
kernel space.  User space need only see finished results.  This part
is not complicated.

- FChE
