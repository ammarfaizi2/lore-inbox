Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWHOTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWHOTPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWHOTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:15:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:42177 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030471AbWHOTPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:15:50 -0400
Subject: Re: [Containers] [PATCH 5/7] pid: Implement pid_nr
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: containers@lists.osdl.org, linux-kernel@vger.kernel.org,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <m1psf17riz.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	 <1155666193751-git-send-email-ebiederm@xmission.com>
	 <1155667063.12700.56.camel@localhost.localdomain>
	 <m1psf17riz.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 12:15:25 -0700
Message-Id: <1155669325.18883.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 13:00 -0600, Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
> >> +static inline pid_t pid_nr(struct pid *pid)
> >> +{
> >> +       pid_t nr = 0;
> >> +       if (pid)
> >> +               nr = pid->nr;
> >> +       return nr;
> >> +} 
> >
> > When is it valid to be passing around a NULL 'struct pid *'?
> 
> When you don't have one at all.  Look at the fcntl case a few
> patches later, or even the spawnpid case.

Does the fcntl() one originate from anywhere other than find_pid() in
f_setown()?  It seems like, perhaps, the error checking is being done at
the wrong level.

> Then of course there is the later chaos when we get to pid spaces
> where depending on the pid namespace you are in when you call this
> on a given struct pid sometimes you will get a pid value and sometimes
> you won't.

OK, I think it is makes sense to me to say 'get_pid(tsk, pidspace)' and
get back a NULL 'struct pid' if that task isn't visible in that
namespace.  However, I don't get how it is handy to be able to defer the
fact that the pid wasn't found until you go do a pid_nr() on that NULL.

-- Dave

