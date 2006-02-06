Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWBFLZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWBFLZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWBFLZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:25:53 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:56518 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750927AbWBFLZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:25:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=lFGz/reLjKb8EsW618Hd73qlfaK3zStsYoJHIORuIzoQX+NyLRSWYT7o8YJsCn5Y8QwqWesBb/KTj1dvjC4tuVnd3TUodURUuADt+X/6b3MbLFI2ojCUh0ujsTKbdjVYUrRr7jo5EsMIeL9vbgM4LwoZpODoJi4UuvEzRkK9lLw=;
Date: Mon, 6 Feb 2006 14:24:35 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
Message-ID: <20060206112435.GC6013@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <20060203140229.GA16266@ms2.inr.ac.ru> <1138983918.6189.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138983918.6189.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In the very, very rare cases where we can't do that (like a fork()
> boundary), we _do_ change the APIs to take both task and container.

I promise you much more of boundary cases, unless
you make some windowsish sys_fork_exec_deal_with_all_the_rest(100 arguments)

Look how this works in openvz. It uses pure traditional unixish api.
Fork is not a boundary at all. To enter to a container you
do all the work in steps:

1. change accounting space (sys_setluid())
2. plain fork()
2. tune communication (pipes, ptys etc)
3. chroot()
...
N. enter container (at the moment it is ioctl on a special device, could be
		   syscall).

You can omit any step, if you need. You can add entering any subsystem,
which you invent in future. Simple and stupid. And, nevertheless, universal.

Alexey
