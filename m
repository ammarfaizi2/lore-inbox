Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUKSGcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUKSGcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 01:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKSGcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 01:32:45 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59796
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261267AbUKSGcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 01:32:42 -0500
Date: Thu, 18 Nov 2004 22:16:56 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, anton@samba.org
Subject: Re: Six archs are missing atomic_inc_return()
Message-Id: <20041118221656.7ae6ef6f.davem@davemloft.net>
In-Reply-To: <20041118204836.09d2d738.akpm@osdl.org>
References: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
	<20041118204836.09d2d738.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 20:48:36 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> >  Six archs do not have the atomic_inc_return() macro as of 2.6.10-rc2:
> > 
> >    cris
> >    h8300
> >    m32r
> >    ppc
> >    ppc64
> >    s390
> 
> All of these architectures implement atomic_add_return().  So they all need
> 
> 	#define atomic_inc_return(v)	atomic_add_return(1, v)
> 
> added to their atomic.h.
> 
> Wanna send a patch?

Come again?  They all seem to have it in current 2.6.x BK as far
as I can tell.

davem@nuts:/disk1/BK/sparc-2.6$ egrep atomic_inc_return include/asm-cris/atomic.h include/asm-h8300/atomic.h include/asm-m32r/atomic.h include/asm-ppc/atomic.h include/asm-ppc64/atomic.h include/asm-s390/atomic.h 
include/asm-cris/atomic.h:extern __inline__ int atomic_inc_return(volatile atomic_t *v)
include/asm-h8300/atomic.h:static __inline__ int atomic_inc_return(atomic_t *v)
include/asm-h8300/atomic.h:#define atomic_inc(v) atomic_inc_return(v)
include/asm-h8300/atomic.h:#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
include/asm-m32r/atomic.h: * atomic_inc_return - increment atomic variable and return it
include/asm-m32r/atomic.h:static inline int atomic_inc_return(atomic_t *v)
include/asm-m32r/atomic.h:		"# atomic_inc_return		\n\t"
include/asm-m32r/atomic.h:#define atomic_inc(v) ((void)atomic_inc_return(v))
include/asm-m32r/atomic.h:#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
include/asm-ppc/atomic.h:static __inline__ int atomic_inc_return(atomic_t *v)
include/asm-ppc/atomic.h:"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
include/asm-ppc/atomic.h:#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
include/asm-ppc64/atomic.h:static __inline__ int atomic_inc_return(atomic_t *v)
include/asm-ppc64/atomic.h:"1:	lwarx	%0,0,%1		# atomic_inc_return\n\
include/asm-ppc64/atomic.h:#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
include/asm-s390/atomic.h:static __inline__ int atomic_inc_return(volatile atomic_t * v)
