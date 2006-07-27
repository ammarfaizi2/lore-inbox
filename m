Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWG0OrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWG0OrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWG0OrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:47:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:18193 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWG0OrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=O1B1Rwhk8Uooi3ekt6gvF1nEodyt5Ic1yRCPahvMm74WYKzKsBwT9HVzqh88WhEUe4EOiwGkN0QeTLcQCeda5lJ+nknpTuxW+//iIsqzSymNA08QWxsSLhmgS241xs/aV4GwtKIbqw6AnRiSZyf5gvdv9tqrPDKQpubPTnx5x+s=
Date: Thu, 27 Jul 2006 18:46:59 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ipc/msg.c: clean up coding style
Message-ID: <20060727144659.GC6825@martell.zuzino.mipt.ru>
References: <20060727135321.GA24644@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727135321.GA24644@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:53:21PM +0200, Ingo Molnar wrote:
> clean up ipc/msg.c to conform to Documentation/CodingStyle. (before it
> was an inconsistent hodepodge of various coding styles)

> --- linux.orig/ipc/msg.c
> +++ linux/ipc/msg.c
> -/* one msg_receiver structure for each sleeping receiver */
> +/*
> + * one msg_receiver structure for each sleeping receiver:
> + */

Was OK.

>  struct msg_receiver {
> -	struct list_head r_list;
> -	struct task_struct* r_tsk;
> +	struct list_head	r_list;
> +	struct task_struct	*r_tsk;

Moving * to name is OK, but lining up all names is probably not.

> -	int r_mode;
> -	long r_msgtype;
> -	long r_maxsize;
> +	int			r_mode;
> +	long			r_msgtype;
> +	long			r_maxsize;
>  
> -	struct msg_msg* volatile r_msg;
> +	volatile struct msg_msg	*r_msg;

First, it was a volatile pointer, now pointer points to volatile data.
Right?

>  /* one msg_sender for each sleeping sender */
>  struct msg_sender {
> -	struct list_head list;
> -	struct task_struct* tsk;
> +	struct list_head	list;
> +	struct task_struct	*tsk;

Let's not lineup fields.

> -static atomic_t msg_bytes = ATOMIC_INIT(0);
> -static atomic_t msg_hdrs = ATOMIC_INIT(0);
> +static atomic_t msg_bytes =	ATOMIC_INIT(0);
> +static atomic_t msg_hdrs =	ATOMIC_INIT(0);

Was OK.

> -asmlinkage long sys_msgget (key_t key, int msgflg)
> +asmlinkage long sys_msgget(key_t key, int msgflg)
>  {
> -	int id, ret = -EPERM;
>  	struct msg_queue *msq;
> +	int id, ret = -EPERM;

For what?

> -static inline unsigned long copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
> +static inline unsigned long
> +copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)

Let's not go BSD way.

>  	case IPC_OLD:
> -	    {
> +	{

Or
	case IPC_OLD: {

> -static inline unsigned long copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)
> +static inline unsigned long
> +copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)

Let's not go BSD way.

>  	case IPC_64:
> -	    {
> +	{

	case IPC_64: {

> -asmlinkage long sys_msgctl (int msqid, int cmd, struct msqid_ds __user *buf)
> +asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
>  {
> -	int err, version;
> -	struct msg_queue *msq;
> -	struct msq_setbuf setbuf;
>  	struct kern_ipc_perm *ipcp;
> -	
> +	struct msq_setbuf setbuf;
> +	struct msg_queue *msq;
> +	int err, version;

There must be logic about moving up and down, but I failed to extract
it. Except you want to see err, rv, retval, ... last.

> @@ -556,6 +567,7 @@ static inline int pipelined_send(struct 
>  				wake_up_process(msr->r_tsk);
>  				smp_mb();
>  				msr->r_msg = msg;
> +
>  				return 1;

Dunno.

> -asmlinkage long sys_msgsnd (int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
> +asmlinkage long
> +sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)

Let's not go BSD way.

> @@ -773,17 +793,17 @@ asmlinkage long sys_msgrcv (int msqid, s
>  		 * wake_up_process(). There is a race with exit(), see
>  		 * ipc/mqueue.c for the details.
>  		 */
> -		msg = (struct msg_msg*) msr_d.r_msg;
> +		msg = (struct msg_msg*)msr_d.r_msg;

msg_msg *, while you're at it.

> @@ -827,20 +848,20 @@ static int sysvipc_msg_proc_show(struct 
>  	struct msg_queue *msq = it;
>  
>  	return seq_printf(s,
> -			  "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
> -			  msq->q_perm.key,
> -			  msq->q_id,
> -			  msq->q_perm.mode,
> -			  msq->q_cbytes,
> -			  msq->q_qnum,
> -			  msq->q_lspid,
> -			  msq->q_lrpid,
> -			  msq->q_perm.uid,
> -			  msq->q_perm.gid,
> -			  msq->q_perm.cuid,
> -			  msq->q_perm.cgid,
> -			  msq->q_stime,
> -			  msq->q_rtime,
> -			  msq->q_ctime);
> +			"%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
> +			msq->q_perm.key,
> +			msq->q_id,
> +			msq->q_perm.mode,
> +			msq->q_cbytes,
> +			msq->q_qnum,
> +			msq->q_lspid,
> +			msq->q_lrpid,
> +			msq->q_perm.uid,
> +			msq->q_perm.gid,
> +			msq->q_perm.cuid,
> +			msq->q_perm.cgid,
> +			msq->q_stime,
> +			msq->q_rtime,
> +			msq->q_ctime);

Was OK.


ObS_IRWXUGOUNREADABLEJUNK: What about

	#define rw_r__r__ 0644
	#define rwxr_xr_x 0755

?

