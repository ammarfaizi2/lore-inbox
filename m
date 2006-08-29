Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWH2T6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWH2T6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWH2T6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:58:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54431 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750846AbWH2T6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:58:17 -0400
Date: Tue, 29 Aug 2006 14:58:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       Joshua Brindle <method@gentoo.org>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060829195814.GA12981@sergelap.austin.ibm.com>
References: <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E45A70.8090801@gentoo.org> <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil> <20060821203656.GA22769@sergelap.austin.ibm.com> <20060828213912.GA428@sergelap.austin.ibm.com> <20060829183710.GO2584@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829183710.GO2584@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Seth Arnold (seth.arnold@suse.de):
> On Mon, Aug 28, 2006 at 04:39:12PM -0500, Serge E. Hallyn wrote:
> > +int cap_task_kill(struct task_struct *p, struct siginfo *info,
> > +				int sig, u32 secid)
> > +{
> > +	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
> > +		return 0;
> > +
> > +	if (secid)
> > +		/*
> > +		 * Signal sent as a particular user.
> > +		 * Capabilities are ignored.  May be wrong, but it's the
> > +		 * only thing we can do at the moment.
> > +		 * Used only by usb drivers?
> > +		 */
> > +		return 0;
> > +	if (current->uid == 0 || current->euid == 0)
> > +		return 0;
> 
> uid/euid checks feel out of place in the capabilities code.

Wow, good point.

Will fix.

thanks,
-serge
