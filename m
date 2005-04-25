Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVDYVZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDYVZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVDYVTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:19:42 -0400
Received: from mail.dif.dk ([193.138.115.101]:34969 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261214AbVDYVOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:14:44 -0400
Date: Mon, 25 Apr 2005 23:17:57 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
In-Reply-To: <20050425165705.GA11938@redhat.com>
Message-ID: <Pine.LNX.4.62.0504252242510.2941@dragon.hyggekrogen.localhost>
References: <20050425165705.GA11938@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, David Teigland wrote:

> [Apologies, patch 1 was too large on its own.]
> 
> The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> Creates lockspaces which give applications separate contexts/namespaces in
> which to do their locking.  Manages locks on resources' grant/convert/wait
> queues.  Sends and receives high level locking operations between nodes.
> Delivers completion and blocking callbacks (ast's) to lock holders.
> Manages the distributed directory that tracks the current master node for
> each resource.
> 
> Signed-Off-By: Dave Teigland <teigland@redhat.com>
> Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
> 
> +#define DLM_LOCK_IV            (-1)	/* invalid */
> +#define DLM_LOCK_NL            (0)	/* null */
> +#define DLM_LOCK_CR            (1)	/* concurrent read */
> +#define DLM_LOCK_CW            (2)	/* concurrent write */
> +#define DLM_LOCK_PR            (3)	/* protected read */
> +#define DLM_LOCK_PW            (4)	/* protected write */
> +#define DLM_LOCK_EX            (5)	/* exclusive */
                                 ^^^^^
                                   |----- Why the parenthesis?
[...]
> +#define DLM_RESNAME_MAXLEN     (64)
                                 ^^^^^--- more parens.
[...]
> +#define DLM_LVB_LEN            (32)
                                 ^^^^^--- yet more.
[...]
> +#define DLM_LKF_NOQUEUE        (0x00000001)
> +#define DLM_LKF_CANCEL         (0x00000002)
> +#define DLM_LKF_CONVERT        (0x00000004)
> +#define DLM_LKF_VALBLK         (0x00000008)
> +#define DLM_LKF_QUECVT         (0x00000010)
> +#define DLM_LKF_IVVALBLK       (0x00000020)
> +#define DLM_LKF_CONVDEADLK     (0x00000040)
> +#define DLM_LKF_PERSISTENT     (0x00000080)
> +#define DLM_LKF_NODLCKWT       (0x00000100)
> +#define DLM_LKF_NODLCKBLK      (0x00000200)
> +#define DLM_LKF_EXPEDITE       (0x00000400)
> +#define DLM_LKF_NOQUEUEBAST    (0x00000800)
> +#define DLM_LKF_HEADQUE        (0x00001000)
> +#define DLM_LKF_NOORDER        (0x00002000)
> +#define DLM_LKF_ORPHAN         (0x00004000)
> +#define DLM_LKF_ALTPR          (0x00008000)
> +#define DLM_LKF_ALTCW          (0x00010000)
                                  ^^^^^^^^^^^^
                                  what's your facination with parenthesis?
[...]
> +#define DLM_ECANCEL            (0x10001)
> +#define DLM_EUNLOCK            (0x10002)
                                  ^--- here we go again.
[...]
> +#define DLM_SBF_DEMOTED        (0x01)
> +#define DLM_SBF_VALNOTVALID    (0x02)
> +#define DLM_SBF_ALTMODE        (0x04)
                                  ^--- and again.
[...]

> +
> +struct dlm_lksb {
> +	int 	 sb_status;
> +	uint32_t sb_lkid;
> +	char 	 sb_flags;
> +	char *	 sb_lvbptr;
why not	char	*sb_lvbptr; ???
[...]
> +#define DLM_LOCKSPACE_LEN	(64)
> +#define DLM_TOSS_SECS		(10)
> +#define DLM_SCAN_SECS		(5)
> +
> +#ifndef TRUE
> +#define TRUE (1)
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE (0)
> +#endif

a few cases of pointless parenthesis around define values...

[...]
> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))

What's wrong with the standard min/max macros from linux/kernel.h ?

[...]

> +#define DLM_ASSERT(x, do) \
> +{ \
> +  if (!(x)) \
> +  { \
> +    printk("\nDLM:  Assertion failed on line %d of file %s\n" \
            ^^^--- a loglevel perhaps?
[...]
> +struct dlm_args {
> +	uint32_t		flags;
> +	void *			astaddr;
	void			*astaddr;
> +	long			astparam;
> +	void *			bastaddr;
	void			*bastaddr;
> +	int			mode;
> +	struct dlm_lksb *	lksb;
	struct dlm_lksb		*lksb;
> +	struct dlm_range *	range;
	struct dlm_range	*range;
> +};
In other locations as well.
[...]

> +#define AST_COMP		(1)
> +#define AST_BAST		(2)
> +
> +/* lkb_range[] */
> +
> +#define GR_RANGE_START		(0)
> +#define GR_RANGE_END		(1)
> +#define RQ_RANGE_START		(2)
> +#define RQ_RANGE_END		(3)
> +
> +/* lkb_status */
> +
> +#define DLM_LKSTS_WAITING	(1)
> +#define DLM_LKSTS_GRANTED	(2)
> +#define DLM_LKSTS_CONVERT	(3)
> +
> +/* lkb_flags */
> +
> +#define DLM_IFL_MSTCPY		(0x00010000)
> +#define DLM_IFL_RESEND		(0x00020000)
> +#define DLM_IFL_RANGE		(0x00000001)

Here, again, we have a lot of pointless parenthesis around the values. I'm 
not going to bother pointing out the remaining ones.

> +static int dlm_astd(void *data)
> +{
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (!test_bit(WAKE_ASTS, &astd_wakeflags))
> +			schedule();
> +		set_current_state(TASK_RUNNING);
> +
> +		down(&astd_running);
> +		if (test_and_clear_bit(WAKE_ASTS, &astd_wakeflags))
> +			process_asts();
> +		up(&astd_running);
> +	}
> +	return 0;
> +}
Always returning 0 - why not a void function then?

[...]

> +
> +int dlm_recover_directory(struct dlm_ls *ls)
> +{
> +	struct dlm_member *memb;
> +	struct dlm_direntry *de;
> +	char *b, *last_name;
> +	int error = -ENOMEM, last_len, count = 0;
Wouldn't
	int error = -ENOMEM;
	int last_len;
	int count = 0;
be a bit more readable?

[...]

> +void dlm_lockspace_exit(void)
> +{
> +}
huh?

[...]
> +int dlm_scand(void *data)
> +{
> +	struct dlm_ls *ls;
> +
> +	while (!kthread_should_stop()) {
> +		list_for_each_entry(ls, &lslist, ls_list)
> +			dlm_scan_rsbs(ls);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(DLM_SCAN_SECS * HZ);
> +	}
> +	return 0;
> +}
void func?

[...]
> +int __init init_dlm(void)
> +{
> +	int error;
> +
> +	error = dlm_memory_init();
> +	if (error)
> +		goto out;
> +
> +	error = dlm_lockspace_init();
> +	if (error)
> +		goto out_mem;
> +
> +	error = dlm_node_ioctl_init();
> +	if (error)
> +		goto out_ls;
> +
> +	error = dlm_member_sysfs_init();
> +	if (error)
> +		goto out_node;
> +
> +	error = dlm_register_debugfs();
> +	if (error)
> +		goto out_member;
> +
> +	error = dlm_lowcomms_init();
> +	if (error)
> +		goto out_debug;
> +
> +	printk("DLM (built %s %s) installed\n", __DATE__, __TIME__);
             ^^^--- how about adding an explicit loglevel?
[...]

> +static inline uint32_t
> +hash_more_internal(const void *data, unsigned int len, uint32_t hash)
A lot of people prefer to have the return type on the same line as the 
function name - very nice when grep'ing for a function to be able to see 
the return type in the grep output.
[...]

> +void dlm_message_out(struct dlm_message *ms)
> +{
> +	struct dlm_header *hd = (struct dlm_header *) ms;
> +
> +	header_out(hd);
> +
> +	ms->m_type		= cpu_to_le32(ms->m_type);
> +	ms->m_nodeid		= cpu_to_le32(ms->m_nodeid);
> +	ms->m_pid		= cpu_to_le32(ms->m_pid);
> +	ms->m_lkid		= cpu_to_le32(ms->m_lkid);
> +	ms->m_remid		= cpu_to_le32(ms->m_remid);
> +	ms->m_parent_lkid	= cpu_to_le32(ms->m_parent_lkid);
> +	ms->m_parent_remid	= cpu_to_le32(ms->m_parent_remid);
> +	ms->m_exflags		= cpu_to_le32(ms->m_exflags);
> +	ms->m_sbflags		= cpu_to_le32(ms->m_sbflags);
> +	ms->m_flags		= cpu_to_le32(ms->m_flags);
> +	ms->m_lvbseq		= cpu_to_le32(ms->m_lvbseq);
> +
why this blank line.?
> +	ms->m_status		= cpu_to_le32(ms->m_status);
> +	ms->m_grmode		= cpu_to_le32(ms->m_grmode);
> +	ms->m_rqmode		= cpu_to_le32(ms->m_rqmode);
> +	ms->m_bastmode		= cpu_to_le32(ms->m_bastmode);
> +	ms->m_asts		= cpu_to_le32(ms->m_asts);
> +	ms->m_result		= cpu_to_le32(ms->m_result);
> +
one more blank line..
> +	ms->m_range[0]		= cpu_to_le64(ms->m_range[0]);
> +	ms->m_range[1]		= cpu_to_le64(ms->m_range[1]);
> +}
> +
> +void dlm_message_in(struct dlm_message *ms)
> +{
> +	struct dlm_header *hd = (struct dlm_header *) ms;
> +
> +	header_in(hd);
> +
> +	ms->m_type		= le32_to_cpu(ms->m_type);
> +	ms->m_nodeid		= le32_to_cpu(ms->m_nodeid);
> +	ms->m_pid		= le32_to_cpu(ms->m_pid);
> +	ms->m_lkid		= le32_to_cpu(ms->m_lkid);
> +	ms->m_remid		= le32_to_cpu(ms->m_remid);
> +	ms->m_parent_lkid	= le32_to_cpu(ms->m_parent_lkid);
> +	ms->m_parent_remid	= le32_to_cpu(ms->m_parent_remid);
> +	ms->m_exflags		= le32_to_cpu(ms->m_exflags);
> +	ms->m_sbflags		= le32_to_cpu(ms->m_sbflags);
> +	ms->m_flags		= le32_to_cpu(ms->m_flags);
> +	ms->m_lvbseq		= le32_to_cpu(ms->m_lvbseq);
> +
again a blank line...
> +	ms->m_status		= le32_to_cpu(ms->m_status);
> +	ms->m_grmode		= le32_to_cpu(ms->m_grmode);
> +	ms->m_rqmode		= le32_to_cpu(ms->m_rqmode);
> +	ms->m_bastmode		= le32_to_cpu(ms->m_bastmode);
> +	ms->m_asts		= le32_to_cpu(ms->m_asts);
> +	ms->m_result		= le32_to_cpu(ms->m_result);
> +
and one more blank line....
> +	ms->m_range[0]		= le64_to_cpu(ms->m_range[0]);
> +	ms->m_range[1]		= le64_to_cpu(ms->m_range[1]);
> +}

[...]

> --- a/drivers/dlm/util.h	1970-01-01 07:30:00.000000000 +0730
> +++ b/drivers/dlm/util.h	2005-04-25 22:52:04.199779824 +0800
> @@ -0,0 +1,23 @@
> +/******************************************************************************
> +*******************************************************************************
> +**
> +**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
> +**  
> +**  This copyrighted material is made available to anyone wishing to use,
> +**  modify, copy, or redistribute it subject to the terms and conditions
> +**  of the GNU General Public License v.2.
> +**
> +*******************************************************************************
> +******************************************************************************/
> +
> +#ifndef __UTIL_DOT_H__
> +#define __UTIL_DOT_H__
> +
> +uint32_t dlm_hash(const char *data, int len);
> +
> +void dlm_message_out(struct dlm_message *ms);
> +void dlm_message_in(struct dlm_message *ms);
> +void dlm_rcom_out(struct dlm_rcom *rc);
> +void dlm_rcom_in(struct dlm_rcom *rc);
> +
> +#endif

No newline at end of file?


-- 
Jesper Juhl

