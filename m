Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWFZQii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWFZQii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWFZQih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:38:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53934 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750782AbWFZQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:38:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: <vgoyal@in.ibm.com>, "Maneesh Soni" <maneesh@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <Neela.Kolli@engenio.com>,
       <linux-scsi@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
References: <E717642AF17E744CA95C070CA815AE550E14E4@cceexc23.americas.cpqcorp.net>
Date: Mon, 26 Jun 2006 10:38:09 -0600
In-Reply-To: <E717642AF17E744CA95C070CA815AE550E14E4@cceexc23.americas.cpqcorp.net>
	(Mike Miller's message of "Mon, 26 Jun 2006 11:13:32 -0500")
Message-ID: <m1lkrjub2m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:

> All,
> Sorry to come in late and top post. I've been out of the office and I'm
> trying to get to the gist of this issue.
> Exactly what is the problem? I'm not familiar with kdump so I don't have
> a clue about what's going on. 
> There are a couple of reset features supported by _some_ cciss
> controllers. I'd have to go back to the open spec to see whats in the
> public domain. We're trying to get the open spec updated and more
> complete but we're waiting on the lawyers. :(


kdump or taking crash dumps using the kexec on panic mechanism could
be called a drivers worst nightmare.  In the latest distros this is
becoming the way crash dump style information is captured.

Because the initial kernel is broken we do a jump into another kernel
that is sufficient to record a crash dump.  That second kernel
initializes the hardware from whatever random state the first
kernel left the drivers in.  That first kernel is not permitted
to do any device shutdown activities.

The problem is that a command the running instance of the driver did
not initiate completes.  At least if I read Vivek patch 2/2 correctly.

So we have three options.
- reset the card during initialization.
- handle the case of a command we did not initiate completing.
- mark the driver/card as impossibly hopeless for use in a crash
  dump scenario.


Eric



