Return-Path: <linux-kernel-owner+w=401wt.eu-S1161174AbXAMBdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbXAMBdk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 20:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbXAMBdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 20:33:40 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:36738 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161174AbXAMBdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 20:33:39 -0500
In-Reply-To: <20061220235216.GA28643@Krystal>
Subject: Re: [PATCH 0/4] Linux Kernel Markers
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Ingo Molnar <mingo@redhat.com>, Douglas Niehaus <niehaus@eecs.ku.edu>,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 7.0.1P Oct 16, 2006
Message-ID: <OFAB3D8A6C.1643F2D3-ON80257262.000581E4-80257262.00088F04@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Sat, 13 Jan 2007 01:33:29 +0000
X-MIMETrack: Serialize by Router on D06MC062/06/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 13/01/2007 01:33:35
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote on 20/12/2006
23:52:16:

> Hi,
>
> You will find, in the following posts, the latest revision of the Linux
Kernel
> Markers. Due to the need some tracing projects (LTTng, SystemTAP) has of
this
> kind of mechanism, it could be nice to consider it for mainstream
inclusion.
>
> The following patches apply on 2.6.20-rc1-git7.
>
> Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Mathiue, FWIW I like this idea. A few years ago I implemented something
similar, but that had no explicit clients. Consequently I made my hooks
code more generalized than is needed in practice. I do remember that Karim
reworked the LTT instrumentation to use hooks and it worked fine.

You've got the same optimizations for x86 by modifying an instruction's
immediate operand and thus avoiding a d-cache hit. The only real caveat is
the need to avoid the unsynchronised cross modification erratum. Which
means that all processors will need to issue a serializing operation before
executing a Marker whose state is changed. How is that handled?

One additional thing we did, which might be useful at some future point,
was adding a /proc interface. We reflected the current instrumentation
though /proc and gave the status of each hook. We even talked about being
able to enable or disabled instrumentation by writing to /proc but I don't
think we ever implemented this.

It's high time we settled the issue of instrumentation. It gets my vote,

Good luck!

Richard

- -
Richard J Moore
IBM Linux Technology Centre

