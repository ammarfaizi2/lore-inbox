Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUGSEzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUGSEzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 00:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUGSEzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 00:55:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40453 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263772AbUGSEzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 00:55:54 -0400
Date: Mon, 19 Jul 2004 06:54:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Paul Jackson <pj@sgi.com>
Cc: solar@openwall.com, tigran@aivazian.fsnet.co.uk, alan@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040719045403.GA8212@alpha.home.local>
References: <20040707234852.GA8297@openwall.com> <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet> <20040718125925.GA20133@openwall.com> <20040718212721.GC1545@alpha.home.local> <20040718161549.5c61d4a9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718161549.5c61d4a9.pj@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 04:15:49PM -0700, Paul Jackson wrote:
> That original shell's mem file will be read by whatever follows, exec or
> not.  The 'exec' just stops the shell from forking before it exec's, and
> certainly won't cause the path that was used earlier to open fd 0 to be
> re-evaluated.

I totally agree, of course, but...

> The setuidapp will see the shell's memory.  In general, a app, setuid or
> not, should make no assumption that any open fd's handed to it at birth
> were opened using the same priviledges that the app itself has.

how can you be sure it will be the shell's memory ? after an exec, the
new process replaces the shell with the same pid. If it overwrites the
same address space, there's a possibility that /proc/self/mem, once
openned, still points to the same structure which will reflect the new
process's space after exec(). I'm afraid I'll have to test it.

Regards,
Willy

