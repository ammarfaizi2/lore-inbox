Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWC3TGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWC3TGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 14:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWC3TGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 14:06:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13186 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750750AbWC3TGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 14:06:40 -0500
Date: Thu, 30 Mar 2006 11:07:58 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       David Lang <dlang@digitalinsight.com>, Sam Vilain <sam@vilain.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330190758.GY15997@sorel.sous-sol.org>
References: <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com> <m1bqvndb7t.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqvndb7t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Frankly I thought, and am still not unconvinced, that containers owned
> > by someone other than the system owner would/should never want to load
> > their own LSMs, so that this wasn't a problem.  Isolation, as Chris has
> > mentioned, would be taken care of by the very nature of namespaces.
> 
> Up to uids I agree.  Once we hit uids things get very ugly.
> And since security modules already seem to touch all of the places
> we need to touch to make a UID namespace work I think using security
> modules to implement the strange things we need with uid.
> 
> To ensure uid isolation we would need a different copy of every other
> namespace.  The pid space would need to be completely isolated,
> and we couldn't share any filesystem mounts with any other namespace.
> This especially includes /proc and sysfs.

Security modules use labels not uid's.  The uid is the basis for
traditional DAC checks, the label are used for MAC checks.  And its
easy to imagine a label that includes a notion of container id.

> However it is possible to build the capacity to multiplex 
> compiled in or already loaded security modules, and allowed which
> security modules are in effect to be controlled by securityfs.

Yes, it's been proposed and discussed many times.  There's some
fundamental issues with composing security modules.  First and foremost
is the notion that arbritrary security models may not compose to form
meaningful (in a security sense) results.  Second, at an implementation
level, sharing labels is non-trivial and comes with overhead.

> With appropriate care we should be able to allow the container
> administrator to use this capability to select which security
> policies, and mechanisms they want. 
> 
> That is something we probably want to consider anyway as
> currently the security modules break the basic rule that
> compiling code in should not affect how the kernel operates
> by default.

Don't follow you on this one.

thanks,
-chris
