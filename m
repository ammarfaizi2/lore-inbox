Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGRXSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGRXSC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUGRXSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 19:18:02 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29468 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264585AbUGRXR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 19:17:59 -0400
Date: Sun, 18 Jul 2004 16:15:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: solar@openwall.com, tigran@aivazian.fsnet.co.uk, alan@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-Id: <20040718161549.5c61d4a9.pj@sgi.com>
In-Reply-To: <20040718212721.GC1545@alpha.home.local>
References: <20040707234852.GA8297@openwall.com>
	<Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
	<20040718125925.GA20133@openwall.com>
	<20040718212721.GC1545@alpha.home.local>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What exactly is passed then ...

The patch /proc/self/mem will be evaluated just once, on the open
by the original shell.  Whatever bucket of bits that resolves to
will remain the source for fd == 0 reads.

That original shell's mem file will be read by whatever follows, exec or
not.  The 'exec' just stops the shell from forking before it exec's, and
certainly won't cause the path that was used earlier to open fd 0 to be
re-evaluated.

The setuidapp will see the shell's memory.  In general, a app, setuid or
not, should make no assumption that any open fd's handed to it at birth
were opened using the same priviledges that the app itself has.

Or, more to the point, no higher priviledge app, when calling down to a
lessor priviledge app (say a setuid or root app invoking a less trusted
app) should allow any open file descriptors across the fork or exec,
except those open on files to which it determines the lessor context has
rights.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
