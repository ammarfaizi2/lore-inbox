Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966007AbWKIOCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966007AbWKIOCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966008AbWKIOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:02:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10374 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S966007AbWKIOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:02:53 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
       Andi Kleen <ak@muc.de>, magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost>
	<20061102101949.452.23441.sendpatchset@localhost>
Date: Thu, 09 Nov 2006 07:00:22 -0700
In-Reply-To: <20061102101949.452.23441.sendpatchset@localhost> (Magnus Damm's
	message of "Thu, 02 Nov 2006 19:19:49 +0900")
Message-ID: <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> elf: Align elf notes properly
>
> The kernel currently contains several elf note aligment implementations. Most
> implementations follow the spec on 32-bit platforms, but none current aligns
> the notes correctly on 64-bit platforms. This patch tries to fix this by
> interpreting the 64-bit and 32-bit elf specs as the following:
>
> offset bytes name
> 0      4     n_namesz -+                  -+
> 4      4     n_descsz  | elf note header   |
> 8      4     n_type   -+                   | elf note entry size - N4
> 12     N1    name                          |
> N2     N3    desc                         -+
>
> WS = word size in bytes (4 for 32 bit, 8 for 64 bit)
> N1 = roundup(n_namesz + sizeof(elf note header), WS) - sizeof(elf note header)
> N2 = sizeof(elf note header) + N1
> N3 = roundup(n_descsz, WS)
> N4 = sizeof(elf note header) + N1 + N2
>
> The elf note header contains three 32-bit values on 32-bit and 64-bit systems. 
> The header is followed by name and desc data together with padding. The 
> alignment and padding varies depending on the word size.

I see your point and I disagree.  The notes in a kernel generated 
core dump do not vary in size.  Find me some implementation evidence that
anyone ever added the extra 4 bytes of alignment to the description and the
padding fields and I will be ready to consider this.  Currently this
just appears to be reading a draft spec that doesn't match reality.

Eric
