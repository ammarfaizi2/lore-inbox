Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbUCXNAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUCXNAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:00:12 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:6027 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263329AbUCXNAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:00:07 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Hans-Peter Jansen <hpj@urpla.net>
Date: Wed, 24 Mar 2004 13:59:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fai
Cc: linux-kernel@vger.kernel.org, mlists@arhont.com
X-mailer: Pegasus Mail v3.50
Message-ID: <19772436779@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 04 at 11:43, Hans-Peter Jansen wrote:
> On Tuesday 23 March 2004 23:05, Andrei Mikhailovsky wrote:
> > I have successfully installed (well actually upgraded) to 4.5.1
> > from 4.0.5. No patches where required and everything seems to work
> > like a charm.
> 
> Am I right, that you're running on i586, while the problem expose
> on x86_64 arch?

Not only. It builds & runs without patches if you use "right" x86_64
kernels. Patch you posted is needed on SuSE (AFAIK) 2.4.x kernels and
on 2.6.x kernels, while RedHat 2.4.x kernels works without patch. On
other side ffs(0) returns 33 on RedHat's 2.4.x kernels (at least on
one...) which can cause machine lockup in endless loop waiting until
ffs(0) will become 0...

On 2.6.x kernels additionally (problem you are hitting now) SIO*BRIDGE
ioctls were moved from "compatible" to "not so compatible" group.
If you'll just mark them as "compatible", it will work sufficiently
well to get networking in VMware.

Unfortunately I'm not aware about any way how to issue x86_64 ioctls
from 32bit ia32 program, and spawning external program just to perform
one ioctl on some file descriptor looks like overkill.

I'll start supporting x86_64 in vmware-any-any- patches as soon as
someone donates x86_64 system to me, or after ~ September 2004, whatever
comes first. Until then you have to get it to work yourself - change
you made is already done in vmware-any-any-update55, unfortunately
other parts of that update do not build on x86_64 yet...
                                                Petr Vandrovec

