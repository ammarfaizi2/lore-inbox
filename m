Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUCXSzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUCXSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:55:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:37319 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263100AbUCXSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:55:47 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fai
Date: Wed, 24 Mar 2004 19:55:38 +0100
User-Agent: KMail/1.5.4
References: <19772436779@vcnet.vc.cvut.cz>
In-Reply-To: <19772436779@vcnet.vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403241955.38489.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 March 2004 12:59, Petr Vandrovec wrote:
> On 24 Mar 04 at 11:43, Hans-Peter Jansen wrote:
> >
> > Am I right, that you're running on i586, while the problem expose
> > on x86_64 arch?
>
> Not only. It builds & runs without patches if you use "right"
> x86_64 kernels. Patch you posted is needed on SuSE (AFAIK) 2.4.x
> kernels and on 2.6.x kernels, while RedHat 2.4.x kernels works
> without patch. On other side ffs(0) returns 33 on RedHat's 2.4.x
> kernels (at least on one...) which can cause machine lockup in
> endless loop waiting until ffs(0) will become 0...

Hmm, it's a SuSE issue then, nice to know (and easily fixable ;-).

> On 2.6.x kernels additionally (problem you are hitting now)
> SIO*BRIDGE ioctls were moved from "compatible" to "not so
> compatible" group. If you'll just mark them as "compatible", it
> will work sufficiently well to get networking in VMware.

I found it. Fixed it with this patch:

--- include/linux/compat_ioctl.h~	2004-03-12 18:37:26.000000000 +0100
+++ include/linux/compat_ioctl.h	2004-03-24 12:34:30.000000000 +0100
@@ -247,10 +247,10 @@
 COMPATIBLE_IOCTL(SIOCSIFENCAP)
 COMPATIBLE_IOCTL(SIOCGIFENCAP)
 COMPATIBLE_IOCTL(SIOCSIFNAME)
-/* FIXME: not compatible
+/* FIXME: not compatible */
 COMPATIBLE_IOCTL(SIOCSIFBR)
 COMPATIBLE_IOCTL(SIOCGIFBR)
-*/
+/* reactivated for vmware */
 COMPATIBLE_IOCTL(SIOCSARP)
 COMPATIBLE_IOCTL(SIOCGARP)
 COMPATIBLE_IOCTL(SIOCDARP)

> Unfortunately I'm not aware about any way how to issue x86_64
> ioctls from 32bit ia32 program, and spawning external program just
> to perform one ioctl on some file descriptor looks like overkill.

Since networking works as expected, I don't see any reason for this
(I probably missing some aspect..)

> I'll start supporting x86_64 in vmware-any-any- patches as soon as
> someone donates x86_64 system to me, or after ~ September 2004,
> whatever comes first. Until then you have to get it to work

Well, I cannot spend you a machine atm, sorry.

As it appears to me, VMware Inc. owes you __at least__ one ;-)

> yourself - change you made is already done in
> vmware-any-any-update55, unfortunately other parts of that update
> do not build on x86_64 yet...

Oh, well...

>                                                 Petr Vandrovec

My last issue is a cosmetical one. Is it expected, that in VMware GUI,
the menu and all edit fields are rendered in a fixed space font (looks
like "ETL Fixed"), which looks quite strange?

Thanks for your help,
Pete

