Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbWKGQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbWKGQna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWKGQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:43:30 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:34789 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964990AbWKGQn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:43:29 -0500
Date: Tue, 7 Nov 2006 10:43:08 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
Message-ID: <20061107164308.GC18660@sergelap.austin.ibm.com>
References: <20061107034550.GA13693@sergelap.austin.ibm.com> <1162911403.3009.33.camel@moss-spartans.epoch.ncsc.mil> <20061107151020.GA18660@sergelap.austin.ibm.com> <1162913217.3009.38.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162913217.3009.38.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2006-11-07 at 09:10 -0600, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > On Mon, 2006-11-06 at 21:45 -0600, Serge E. Hallyn wrote:
> > > > Implement file posix capabilities.  This allows programs to be given
> > > > a subset of root's powers regardless of who runs them, without
> > > > having to use setuid and giving the binary all of root's powers.
> > > 
> > > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > > index b200b98..ea631ee 100644
> > > > --- a/include/linux/security.h
> > > > +++ b/include/linux/security.h
> > > > @@ -53,6 +53,10 @@ extern int cap_inode_setxattr(struct den
> > > >  extern int cap_inode_removexattr(struct dentry *dentry, char *name);
> > > >  extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
> > > >  extern void cap_task_reparent_to_init (struct task_struct *p);
> > > > +extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
> > > > +extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
> > > > +extern int cap_task_setioprio (struct task_struct *p, int ioprio);
> > > > +extern int cap_task_setnice (struct task_struct *p, int nice);
> > > >  extern int cap_syslog (int type);
> > > >  extern int cap_vm_enough_memory (long pages);
> > > >  
> > > > @@ -2594,12 +2598,12 @@ static inline int security_task_setgroup
> > > >  
> > > >  static inline int security_task_setnice (struct task_struct *p, int nice)
> > > >  {
> > > > -	return 0;
> > > > +	return cap_task_setnice(p, nice);
> > > >  }
> > > >  
> > > >  static inline int security_task_setioprio (struct task_struct *p, int ioprio)
> > > >  {
> > > > -	return 0;
> > > > +	return cap_task_setioprio(p, ioprio);
> > > >  }
> > > >  
> > > >  static inline int security_task_getioprio (struct task_struct *p)
> > > 
> > > setscheduler change seems to be missing here.
> > 
> > I'm confused - my kernel version already had selinux_task_setscheduler()
> > calling a secondary_ops->task_setscheduler().
> 
> I meant you didn't change the default implementation of
> security_task_setscheduler() to call cap_task_setscheduler() in
> security.h.  For the case where CONFIG_SECURITY is not defined.

Oh, I thought my git tree had gotten messed up.

So I guess that CONFIG_SECURITY_FS_CAPABILITIES should not be dependent
on CONFIG_SECURITY_CAPABILITIES, since the !CONFIG_SECURITY case
actually enables capabilities?

-serge
