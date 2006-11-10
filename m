Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424386AbWKJIuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424386AbWKJIuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424387AbWKJIuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:50:52 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3340 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1424386AbWKJIuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:50:51 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Undeprecate sys_sysctl
Date: Fri, 10 Nov 2006 08:50:50 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com> <200611092317.26459.s0348365@sms.ed.ac.uk> <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejsbnagm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100850.50281.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 05:21, Eric W. Biederman wrote:
> Alistair John Strachan <s0348365@sms.ed.ac.uk> writes:
> > On Wednesday 08 November 2006 19:00, you wrote:
> >> The basic issue is that despite have been deprecated and warned about
> >> as a very bad thing in the man pages since its inception there are a
> >> few real users of sys_sysctl.  It was my assumption that because
> >> sysctl had been deprecated for all of 2.6 there would be no user space
> >> users by this point, so I initially gave sys_sysctl a very short
> >> deprecation period.
> >>
> >> Now that I know there are a few real users the only sane way to
> >> proceed with deprecation is to push the time limit out to a year or
> >> two work and work with distributions that have big testing pools like
> >> fedora core to find these last remaining users.
> >
> > Eric, do you have a list of the remaining users? It'd be good to know for
> > people using Linux in an embedded environment, where they may want to
> > switch off the option, but only if it doesn't break their userspace.
>
> They are very very few.  The ones I recall are kudzu, radvd, and
> libpthreads (which doesn't care).

Neither do new versions of radvd, from what I can see.

radvd.c/check_ip6_forwarding():

#ifdef __linux__
	fp = fopen(PROC_SYS_IP6_FORWARDING, "r");
	if (fp) {
		fscanf(fp, "%d", &value);
		fclose(fp);
	}
	else
		flog(LOG_DEBUG, "Correct IPv6 forwarding procfs entry not found, "
	                       "perhaps the procfs is disabled, "
	                        "or the kernel interface has changed?");
#endif /* __linux__ */

	if (!fp && sysctl(forw_sysctl, sizeof(forw_sysctl)/sizeof(forw_sysctl[0]),
	    &value, &size, NULL, 0) < 0) {
		flog(LOG_DEBUG, "Correct IPv6 forwarding sysctl branch not found, "
			"perhaps the kernel interface has changed?");
		return(0);	/* this is of advisory value only */
	}

Maybe you should just hold out until everybody fixes their programs ;-)

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
