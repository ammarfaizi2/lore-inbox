Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTH0Pdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTH0Pdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:33:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:45487 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263408AbTH0Pds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:33:48 -0400
Date: Wed, 27 Aug 2003 11:35:11 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp64-178.boston.redhat.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.22
In-Reply-To: <Pine.LNX.4.53.0308261327540.229@chaos>
Message-ID: <Pine.LNX.4.44.0308271127150.1491-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Aug 2003, Richard B. Johnson wrote:

> 
> I configured, built and booted Linux-2.4.22. There are
> some problems.
> 
> (1) `dmesg` fails to read the first part of the buffered
> kernel log. I have attached two files, dmesg-20 (normal)

sounds like the log buffer wrapped around from a lot of printks

> (3)  When umounting the root file-system, the machine usually
> hangs. The result is a long `fsck` on the next boot. The problem
> seems to be that sendmail doesn't get killed during the `init 0`
> sequence. It remains with a file open and the root file-system isn't
> unmounted. A temporary work-round is to `ifconfig eth0 down` before
> starting shutdown. Otherwise, sendmail remains stuck in the 'D' state.

this is likely the unshare_files change, which has been mentioned in
several threads as causing similar type issues...i posted a patch that
solves the issue, and Alan included a patch in his -ac series, which 
also addresses this issue.  

-Jason

