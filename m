Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264282AbVBEHtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbVBEHtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 02:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbVBEHtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 02:49:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42911 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S266469AbVBEHso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 02:48:44 -0500
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Pekka Enberg <penberg@gmail.com>, linuxppc64-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org,
       anton@samba.org, trini@kernel.crashing.org, benh@kernel.crashing.org,
       hpa@zytor.com, akpm@osdl.org
In-Reply-To: <20050204172041.GA17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	 <84144f0205020400172d89eddf@mail.gmail.com>
	 <20050204172041.GA17586@austin.ibm.com>
Date: Sat, 05 Feb 2005 09:48:19 +0200
Message-Id: <1107589699.17616.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 11:20 -0600, Olof Johansson wrote:
> * cpu-has-feature(cpu-feature-foo) v cpu-has-feature(foo): I picked the
> latter for readability.
> * Renaming CPU_FTR_<x> -> CPU_<x> makes it less obvious that
> it's actually a cpu feature it's describing (i.e. CPU_ALTIVEC vs
> CPU_FTR_ALTIVEC).
> * Renaming would clobber the namespace, CPU_* definitions are used in
> other places in the tree.
> * Can't make it an inline and still use the preprocessor concatenation.

Seriously, if readability is your argument, macro magic is not the
answer. Ok, we can't clobber the CPU_ definitions, so pick another
prefix.

If you want readability, please consider using named enums:

enum cpu_feature {
	CF_ALTIVEC = /* ... */
};

static inline int cpu_has_feature(enum cpu_feature cf) { }

			Pekka

