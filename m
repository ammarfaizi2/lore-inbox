Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJDRNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJDRNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 13:13:24 -0400
Received: from 12-207-41-15.client.attbi.com ([12.207.41.15]:45586 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S262609AbTJDRNV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 13:13:21 -0400
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sysklogd: use up-to-date query_module() routine
Date: Sat, 4 Oct 2003 12:13:19 -0500
User-Agent: KMail/1.5.2
References: <200310031942.50234.kelledin+LKML@skarpsey.dyndns.org> <yw1x7k3lajx4.fsf@users.sourceforge.net> <200310032036.29519.kelledin+LKML@skarpsey.dyndns.org>
In-Reply-To: <200310032036.29519.kelledin+LKML@skarpsey.dyndns.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v+vf/BuDD0xzMLf"
Message-Id: <200310041213.19445.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_v+vf/BuDD0xzMLf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 03 October 2003 08:36 pm, Kelledin wrote:
> 2) migrate klogd to use query_module() rather than stepping
> through /dev/kmem.  query_module() should provide everything
> that klogd normally pokes around /dev/kmem for.  Does it rely
> indirectly on being able to step through kmem?  I hope not...

Well, I settled on this option, and I've got something that seems 
to work.  The kmem walker hack is no longer needed, the llseek() 
VFS limitations are now a pretty moot point, and an 
obsolete/dangerous syscall got nudged further towards oblivion.

(Oh, and klogd no longer segv's on my EV56 box, which was really 
the point of this exercise to begin with. ;)

I've attached the patch below in case anyone is interested; I 
also sent it off to the sysklogd maintainers (finally found 
them).  Testing and constructive criticism is encouraged.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

--Boundary-00=_v+vf/BuDD0xzMLf
Content-Type: application/x-bzip2;
  name="sysklogd-1.4.1-querymodules.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sysklogd-1.4.1-querymodules.patch.bz2"

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
FCQt1M8vAA==

--Boundary-00=_v+vf/BuDD0xzMLf--

