Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUG2Qmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUG2Qmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUG2Qgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:36:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26555 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264937AbUG2QCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:02:03 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       jbarnes@engr.sgi.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
	<m1d62f6351.fsf@ebiederm.dsl.xmission.com>
	<20040728180954.1f2baed9.akpm@osdl.org>
	<m1u0vr4luo.fsf@ebiederm.dsl.xmission.com>
	<138620000.1091110702@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 10:01:18 -0600
In-Reply-To: <138620000.1091110702@[10.10.2.4]>
Message-ID: <m1pt6ekdkh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> IIRC, what Adam did is to relocate the bottom 16MB of mem into the
> reserved buffer and execute into the bottom 16MB. Yes, that probably does
> leave some DMA issues that we should fix up as you suggest above, but I
> think it's good enough for a first pass at the problem.

Probably.  I have witnessed network RX causing memory corruption,
before the kexec code started downing the network interfaces on
the user space side. I suspect data capture from sound cards or
video capture cards would have the same issue.  

The way I have observed this in the past is to kexec memtest86,
on a machine with known good memory, and then attempt to ping it :)

What especially worries me about the low 16MB is that it is the
DMA zone for ISA devices.  Old sound cards in particular.  Most
of that is output but....   

Eric
