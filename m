Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWHQA1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWHQA1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWHQA1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:27:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:7865 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932160AbWHQA1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:27:01 -0400
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>, linuxppc-dev@ozlabs.org,
       mingo@elte.hu, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1155772859.15360.12.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	 <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	 <yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	 <1155318983.5337.2.camel@localhost.localdomain>
	 <1155771487.11312.114.camel@localhost.localdomain>
	 <1155772859.15360.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 02:26:07 +0200
Message-Id: <1155774368.11312.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hey Ben,
> 	I appreciate your looking over my patch. You are correct, the
> conversion is a bit rough and I've not yet been able to work on the
> powerpc vDSO, although I'd like to get it working so any help or
> suggestions would be appreciated (is there a reason the vDSO is written
> in ASM?).
> 
> If you have any other concerns w/ that patch, or the generic timekeeping
> code, please let me know and I'll do what I can to address them.

Well, I've been wanting to look at your stuff and possibly do the
conversion for some time, provided we don't lose performances ... Our
current implementation is very optimized to avoid even memory barriers
in most cases and I doubt we'll be able to be as fine tuned using your
generic code, thus it's a tradeoff decision that we have to do. But
then, I need to look into the details before doing any final
statement :)

As for why the vDSO is in assembly, well... because it's kewl ? :) More
seriously, because it's much more simpler that way (and it's hand
optimized in a couple of places, though that would probably benefit
going through a proper scheduling analysis). The vDSO code has "special"
calling conventions (like the need to tweak cr.so, the non-use of the
TOC, the lack of procedure descriptors, symbols are offsets to the
functions, etc...) that makes it awkward to write it in C.

Ben


