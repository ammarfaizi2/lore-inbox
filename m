Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424343AbWKJEAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424343AbWKJEAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424344AbWKJEAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:00:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:24916 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424343AbWKJEAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:00:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JhF+gvNn1Wj7lxLiwEG5yhejRAs6ilNhfttKjZGmMYheqzd5EcvVag6KSNdzaQa1t1Vw8b5TtBWybNQbD2Bdp8Ial0rarcJ0AIk+TeNCCWY2CH9KzGIN1vmhFIlm+Gi6+FykNMfxIUQutPjvbxcQCjFAuS6jajipCHYXPmdPLA4=
Message-ID: <aec7e5c30611092000k397fb578xc59a990043fc310a@mail.gmail.com>
Date: Fri, 10 Nov 2006 13:00:09 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: Horms <horms@verge.net.au>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org, "Dave Anderson" <anderson@redhat.com>
In-Reply-To: <20061110005051.GB4107@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102101942.452.73192.sendpatchset@localhost>
	 <20061102101949.452.23441.sendpatchset@localhost>
	 <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>
	 <20061110005051.GB4107@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Horms <horms@verge.net.au> wrote:
> On Thu, Nov 09, 2006 at 07:00:22AM -0700, Eric W. Biederman wrote:
> > Magnus Damm <magnus@valinux.co.jp> writes:
> >
> > > elf: Align elf notes properly
> > >
> > > The kernel currently contains several elf note aligment implementations. Most
> > > implementations follow the spec on 32-bit platforms, but none current aligns
> > > the notes correctly on 64-bit platforms. This patch tries to fix this by
> > > interpreting the 64-bit and 32-bit elf specs as the following:
> > >
> > > offset bytes name
> > > 0      4     n_namesz -+                  -+
> > > 4      4     n_descsz  | elf note header   |
> > > 8      4     n_type   -+                   | elf note entry size - N4
> > > 12     N1    name                          |
> > > N2     N3    desc                         -+
> > >
> > > WS = word size in bytes (4 for 32 bit, 8 for 64 bit)
> > > N1 = roundup(n_namesz + sizeof(elf note header), WS) - sizeof(elf note header)
> > > N2 = sizeof(elf note header) + N1
> > > N3 = roundup(n_descsz, WS)
> > > N4 = sizeof(elf note header) + N1 + N2
> > >
> > > The elf note header contains three 32-bit values on 32-bit and 64-bit systems.
> > > The header is followed by name and desc data together with padding. The
> > > alignment and padding varies depending on the word size.
> >
> > I see your point and I disagree.  The notes in a kernel generated
> > core dump do not vary in size.  Find me some implementation evidence that
> > anyone ever added the extra 4 bytes of alignment to the description and the
> > padding fields and I will be ready to consider this.  Currently this
> > just appears to be reading a draft spec that doesn't match reality.
>
> Or perhaps a spec that hasn't been implemented correctly.
> I guess that the real question is, what padding is correct?

I see no point in aligning to 32-bit boundaries on 64-bit platforms.
Their intention was most likely to align to the word size IMO, so this
is most likely a "thinko" left over from whoever ported the code from
32-bit to 64-bit.

How we chose to align on 64-bit platforms is another issue, either we
fix it soon or live with the fact that we are not following the 64-bit
draft spec. Either way is fine with me.

/ magnus
