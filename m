Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWGOGET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWGOGET (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 02:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWGOGET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 02:04:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63174 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422800AbWGOGES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 02:04:18 -0400
Date: Sat, 15 Jul 2006 02:04:00 -0400
From: Dave Jones <davej@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
Message-ID: <20060715060400.GC5557@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060715002623.GE9334@gondor.apana.org.au> <20060714173517.cdd58097.akpm@osdl.org> <20060715010645.GB11515@gondor.apana.org.au> <20060714.224001.71089810.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714.224001.71089810.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 10:40:01PM -0700, David Miller wrote:
 > From: Herbert Xu <herbert@gondor.apana.org.au>
 > Date: Sat, 15 Jul 2006 11:06:45 +1000
 > 
 > > -	__ret;						\
 > > +	unlikely(__ret);				\
 > 
 > Wouldn't it be cleaner to wrap this unlikely around
 > the top-level "({ })"?  When it sits on a line by
 > itself it looks strange, that much is true :)
 > 
 > Actually, the last time I saw a construct like this
 > it was a bug, someone was doing:
 > 
 > 	return unlikely(someval);
 > 
 > which turned someval into a boolean, even though what
 > was intended was that the full value was returned.

Ick, nasty.  Seems there's quite a few instances of that construct around.

arch/frv/kernel/gdb-stub.c:     return likely(!brr);
arch/frv/kernel/gdb-stub.c:     return likely(!brr);
arch/frv/kernel/gdb-stub.c:     return likely(!brr);
arch/frv/kernel/gdb-stub.c:     return likely(!brr);
arch/frv/kernel/gdb-stub.c:     return likely(!brr);
arch/frv/kernel/gdb-stub.c:     return likely(!brr);
net/sched/em_cmp.c:     return unlikely(cmp->flags & TCF_EM_CMP_TRANS);
net/dccp/options.c:     return likely(ndp <= 0xFF) ? 1 : ndp <= 0xFFFF ? 2 : 3;
fs/hugetlbfs/inode.c:   return likely(capable(CAP_IPC_LOCK) ||
fs/hugetlbfs/inode.c:   return likely(capable(CAP_IPC_LOCK) ||
include/linux/seccomp.h:        return unlikely(test_ti_thread_flag(ti, TIF_SECCOMP));
include/linux/ipv6.h:   return likely(sk->sk_state != TCP_TIME_WAIT) ?
include/linux/ipv6.h:   return likely(sk->sk_state != TCP_TIME_WAIT) ?
include/linux/tracehook.h:      return unlikely(p->utrace != NULL);
include/linux/tracehook.h:      return unlikely(tsk->utrace_flags & UTRACE_ACTION_QUIESCE);
include/linux/swapops.h:        return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
include/linux/swapops.h:        return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
include/linux/mm.h:     return (unlikely(pgd_none(*pgd)) && __pud_alloc(mm, pgd, address))?
include/linux/mm.h:     return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
include/linux/sched.h:  return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
include/linux/sched.h:  return unlikely(test_thread_flag(TIF_NEED_RESCHED));
include/linux/skbuff.h: return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
include/linux/skbuff.h: return unlikely(len > skb->len) ? NULL : __pskb_pull(skb, len);
include/net/inet_timewait_sock.h:       return likely(sk->sk_state != TCP_TIME_WAIT) ?
include/net/pkt_cls.h:  return unlikely((ptr + len) < skb->tail && ptr > skb->head);
include/asm-frv/uaccess.h:      return likely(__access_ok(to, n)) ? __copy_to_user(to, from, n) : n; 

		Dave

-- 
http://www.codemonkey.org.uk
