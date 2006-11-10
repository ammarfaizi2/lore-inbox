Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424332AbWKJBHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424332AbWKJBHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424324AbWKJBHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:07:55 -0500
Received: from koto.vergenet.net ([210.128.90.7]:47777 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1424332AbWKJBHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:07:53 -0500
Date: Fri, 10 Nov 2006 09:50:52 +0900
From: Horms <horms@verge.net.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Message-ID: <20061110005051.GB4107@verge.net.au>
References: <20061102101942.452.73192.sendpatchset@localhost> <20061102101949.452.23441.sendpatchset@localhost> <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 07:00:22AM -0700, Eric W. Biederman wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> 
> > elf: Align elf notes properly
> >
> > The kernel currently contains several elf note aligment implementations. Most
> > implementations follow the spec on 32-bit platforms, but none current aligns
> > the notes correctly on 64-bit platforms. This patch tries to fix this by
> > interpreting the 64-bit and 32-bit elf specs as the following:
> >
> > offset bytes name
> > 0      4     n_namesz -+                  -+
> > 4      4     n_descsz  | elf note header   |
> > 8      4     n_type   -+                   | elf note entry size - N4
> > 12     N1    name                          |
> > N2     N3    desc                         -+
> >
> > WS = word size in bytes (4 for 32 bit, 8 for 64 bit)
> > N1 = roundup(n_namesz + sizeof(elf note header), WS) - sizeof(elf note header)
> > N2 = sizeof(elf note header) + N1
> > N3 = roundup(n_descsz, WS)
> > N4 = sizeof(elf note header) + N1 + N2
> >
> > The elf note header contains three 32-bit values on 32-bit and 64-bit systems. 
> > The header is followed by name and desc data together with padding. The 
> > alignment and padding varies depending on the word size.
> 
> I see your point and I disagree.  The notes in a kernel generated 
> core dump do not vary in size.  Find me some implementation evidence that
> anyone ever added the extra 4 bytes of alignment to the description and the
> padding fields and I will be ready to consider this.  Currently this
> just appears to be reading a draft spec that doesn't match reality.

Or perhaps a spec that hasn't been implemented correctly.
I guess that the real question is, what padding is correct?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

