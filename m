Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVC2PmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVC2PmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVC2PmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:42:20 -0500
Received: from bethe.phy.uc.edu ([129.137.4.14]:31635 "EHLO bethe.phy.uc.edu")
	by vger.kernel.org with ESMTP id S262319AbVC2PmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:42:17 -0500
From: Andrew Pinski <pinskia@physics.uc.edu>
Message-Id: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
To: jakub@redhat.com
Date: Tue, 29 Mar 2005 10:42:04 -0500 (EST)
Cc: vda@ilport.com.ua (Denis Vlasenko), linux-kernel@vger.kernel.org,
       gcc@gcc.gnu.org
In-Reply-To: <20050329151305.GQ4961@sunsite.mff.cuni.cz>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -104.901 () BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Mar 29, 2005 at 05:37:06PM +0300, Denis Vlasenko wrote:
> > /*
> >  * This looks horribly ugly, but the compiler can optimize it totally,
> >  * as the count is constant.
> >  */
> > static inline void * __constant_memcpy(void * to, const void * from, size_t n)
> > {
> >         if (n <= 128)
> >                 return __builtin_memcpy(to, from, n);
> The problem is that in GCC < 4.0 there is no constant propagation
> pass before expanding builtin functions, so the __builtin_memcpy
> call above sees a variable rather than a constant.

or change "size_t n" to "const size_t n" will also fix the issue.
As we do some (well very little and with inlining and const values)
const progation before 4.0.0 on the trees before expanding the builtin.

-- Pinski
