Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTEGVTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTEGVTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:19:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264233AbTEGVTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:19:07 -0400
Date: Wed, 7 May 2003 14:27:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marcus Alanen <marcus@infa.abo.fi>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.69
Message-Id: <20030507142759.6f93e589.rddunlap@osdl.org>
In-Reply-To: <200305072127.h47LR1Z14629@infa.abo.fi>
References: <3EB95BD7.8060700@pobox.com>
	<20030507132024.GB18177@wohnheim.fh-wedel.de>
	<Pine.LNX.4.53.0305070933450.11740@chaos>
	<1052332566.752437@palladium.transmeta.com>
	<3EB95BD7.8060700@pobox.com>
	<20030507133856.02748f4e.rddunlap@osdl.org>
	<200305072127.h47LR1Z14629@infa.abo.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003 00:27:01 +0300 Marcus Alanen <marcus@infa.abo.fi> wrote:

| On Wed, 7 May 2003 13:38:56 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
| >I have mostly used kmalloc/kfree, but using automatic variables is certainly
| >cleaner to write (code).  One of the patches that I did just made each ioctl
| >cmd call a separate function, and then each separate function was able to use
| >automatic variables on the stack instead of kmalloc/kfree.  I prefer this
| >method when it's feasible (and until gcc can handle these cases).
| 
| I take it moving the automatic variables in the function to a static
| data area would be possible, _if_ that function (or rather, the
| variables) is protected by some unique lock (not some per-structure
| lock, of course)? Although this is probably already done in the
| majority of cases.

Sure, it just means that use of those areas has to be serialized,
whereas the other ways allow reentrant/concurrent uses.

--
~Randy
