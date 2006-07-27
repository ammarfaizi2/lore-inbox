Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWG0Qaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWG0Qaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWG0Qai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:30:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60602 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751513AbWG0Qai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:30:38 -0400
Date: Thu, 27 Jul 2006 18:24:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ipc/msg.c: clean up coding style
Message-ID: <20060727162434.GA29489@elte.hu>
References: <20060727135321.GA24644@elte.hu> <20060727144659.GC6825@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727144659.GC6825@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Thu, Jul 27, 2006 at 03:53:21PM +0200, Ingo Molnar wrote:
> > clean up ipc/msg.c to conform to Documentation/CodingStyle. (before it
> > was an inconsistent hodepodge of various coding styles)
> 
> > --- linux.orig/ipc/msg.c
> > +++ linux/ipc/msg.c
> > -/* one msg_receiver structure for each sleeping receiver */
> > +/*
> > + * one msg_receiver structure for each sleeping receiver:
> > + */
> 
> Was OK.

but it was not consistent. So i made it so.

> >  struct msg_receiver {
> > -	struct list_head r_list;
> > -	struct task_struct* r_tsk;
> > +	struct list_head	r_list;
> > +	struct task_struct	*r_tsk;
> 
> Moving * to name is OK, but lining up all names is probably not.

again, it was not consistent, i made it so. It's perfectly fine to line 
up names, especially in structure declarations.

> > -	int r_mode;
> > -	long r_msgtype;
> > -	long r_maxsize;
> > +	int			r_mode;
> > +	long			r_msgtype;
> > +	long			r_maxsize;
> >  
> > -	struct msg_msg* volatile r_msg;
> > +	volatile struct msg_msg	*r_msg;
> 
> First, it was a volatile pointer, now pointer points to volatile data.
> Right?

the volatile is quite likely bogus anyway. It made no difference to the 
assembly output.

> >  /* one msg_sender for each sleeping sender */
> >  struct msg_sender {
> > -	struct list_head list;
> > -	struct task_struct* tsk;
> > +	struct list_head	list;
> > +	struct task_struct	*tsk;
> 
> Let's not lineup fields.

again, consistency.

> > -static atomic_t msg_bytes = ATOMIC_INIT(0);
> > -static atomic_t msg_hdrs = ATOMIC_INIT(0);
> > +static atomic_t msg_bytes =	ATOMIC_INIT(0);
> > +static atomic_t msg_hdrs =	ATOMIC_INIT(0);
> 
> Was OK.

again, consistency.

> > -asmlinkage long sys_msgget (key_t key, int msgflg)
> > +asmlinkage long sys_msgget(key_t key, int msgflg)
> >  {
> > -	int id, ret = -EPERM;
> >  	struct msg_queue *msq;
> > +	int id, ret = -EPERM;
> 
> For what?

that's how i mark functions that i cleaned up, i order the variable 
lines by length. (take a look at kernel/sched.c, kernel/rtmutex.c, 
kernel/lockdep.c, etc., etc.) It also looks a tiny bit more structured 
than the usual random dump of variable definitions.

> > -static inline unsigned long copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
> > +static inline unsigned long
> > +copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
> 
> Let's not go BSD way.

lets not go for longer than 80 chars.

> >  	case IPC_OLD:
> > -	    {
> > +	{
> 
> Or
> 	case IPC_OLD: {

again, consistency. Most places in this file used the one to what i 
corrected it above.

> > -static inline unsigned long copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)
> > +static inline unsigned long
> > +copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)
> 
> Let's not go BSD way.

again, lets not have overlong line 80 prototypes.

> > -	int err, version;
> > -	struct msg_queue *msq;
> > -	struct msq_setbuf setbuf;
> >  	struct kern_ipc_perm *ipcp;
> > -	
> > +	struct msq_setbuf setbuf;
> > +	struct msg_queue *msq;
> > +	int err, version;
> 
> There must be logic about moving up and down, but I failed to extract 
> it. Except you want to see err, rv, retval, ... last.

take a look at the resulting file.

> > -		msg = (struct msg_msg*) msr_d.r_msg;
> > +		msg = (struct msg_msg*)msr_d.r_msg;
> 
> msg_msg *, while you're at it.

yep.

> > @@ -827,20 +848,20 @@ static int sysvipc_msg_proc_show(struct 
> >  	struct msg_queue *msq = it;
> >  
> >  	return seq_printf(s,
> > -			  "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
> > -			  msq->q_perm.key,
> > -			  msq->q_id,
> > -			  msq->q_perm.mode,
> > -			  msq->q_cbytes,
> > -			  msq->q_qnum,
> > -			  msq->q_lspid,
> > -			  msq->q_lrpid,
> > -			  msq->q_perm.uid,
> > -			  msq->q_perm.gid,
> > -			  msq->q_perm.cuid,
> > -			  msq->q_perm.cgid,
> > -			  msq->q_stime,
> > -			  msq->q_rtime,
> > -			  msq->q_ctime);
> > +			"%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
> > +			msq->q_perm.key,
> > +			msq->q_id,
> > +			msq->q_perm.mode,
> > +			msq->q_cbytes,
> > +			msq->q_qnum,
> > +			msq->q_lspid,
> > +			msq->q_lrpid,
> > +			msq->q_perm.uid,
> > +			msq->q_perm.gid,
> > +			msq->q_perm.cuid,
> > +			msq->q_perm.cgid,
> > +			msq->q_stime,
> > +			msq->q_rtime,
> > +			msq->q_ctime);
> 
> Was OK.

stupid 2 spaces for every line was not OK but we/you can reintroduce 
them after this patch goes in.

(anyway, i'd suggest to also spend some of your review energy on all the 
other 1000 zillion files that have very real and obvious style problems, 
instead of redundantly finetuning the ones i did? The last thing we need 
is the needless blocking of obviously right cleanup patches on small 
silly details, which patches already vastly improve what was there 
before. We can quibble about BSD or non-BSD prototypes after all that 
has been finished.)

	Ingo
