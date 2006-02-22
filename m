Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWBVRfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWBVRfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWBVRfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:35:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161139AbWBVRfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:35:41 -0500
To: linux-kernel@vger.kernel.org
Cc: etsman@cs.huji.ac.il
Subject: Static instrumentation, was Re: RFC: klogger: kernel tracing and logging tool
References: <43FC8261.9000207@gmail.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 22 Feb 2006 12:35:31 -0500
In-Reply-To: <43FC8261.9000207@gmail.com>
Message-ID: <y0mbqwze1p8.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yoav Etsion <etsman@gmail.com> writes:

> [...]  I've developed a kernel logging tool called
> Klogger: http://www.cs.huji.ac.il/~etsman/klogger
> In some senses, it is similar to the LTT [...]

It seems like several projects would benefit from markers being
inserted into key kernel code paths for purposes of tracing / probing.

Both LTTng and klogger have macros that expand to largish inline
function calls that appear to cause a noticeable amount of work even
for tracing requests are not actually active.  (klogger munges
interrupts, gets timestamps, before ever testing whether logging was
requested; lttng similar; icache bloat in both cases.)

In other words, even in the inactive state, tracing markers like those
of klogger and ltt impose some performance disruption.  Assuming that
detailed tracing / probing would be a useful facility to have
available, are there any other factors that block adoption of such
markers in official kernels?  In other words, if they could go "fast
enough", especially in the inactive case, would you start placing them
into your code?


- FChE
