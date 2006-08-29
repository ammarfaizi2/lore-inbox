Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbWH2ShP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbWH2ShP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWH2ShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:37:15 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:27321 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S965044AbWH2ShM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:37:12 -0400
Date: Tue, 29 Aug 2006 11:37:10 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <method@gentoo.org>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060829183710.GO2584@suse.de>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	Joshua Brindle <method@gentoo.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nicholas Miell <nmiell@comcast.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org, chrisw@sous-sol.org
References: <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E45A70.8090801@gentoo.org> <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil> <20060821203656.GA22769@sergelap.austin.ibm.com> <20060828213912.GA428@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E2M0Wzx5stW0r4fF"
Content-Disposition: inline
In-Reply-To: <20060828213912.GA428@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E2M0Wzx5stW0r4fF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2006 at 04:39:12PM -0500, Serge E. Hallyn wrote:
> +int cap_task_kill(struct task_struct *p, struct siginfo *info,
> +				int sig, u32 secid)
> +{
> +	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
> +		return 0;
> +
> +	if (secid)
> +		/*
> +		 * Signal sent as a particular user.
> +		 * Capabilities are ignored.  May be wrong, but it's the
> +		 * only thing we can do at the moment.
> +		 * Used only by usb drivers?
> +		 */
> +		return 0;
> +	if (current->uid == 0 || current->euid == 0)
> +		return 0;

uid/euid checks feel out of place in the capabilities code.

> +	if (capable(CAP_KILL))
> +		return 0;
> +	if (cap_issubset(p->cap_permitted, current->cap_permitted))
> +		return 0;
> +
> +	return -EPERM;
> +}

Thanks Serge

--E2M0Wzx5stW0r4fF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFE9IlW+9nuM9mwoJkRAn0cAJ40P3hhRLEs7oWTco80Rnqqhtu6uACfQh/k
xkajonFyRIUQ26TuB3knS9E=
=pUu9
-----END PGP SIGNATURE-----

--E2M0Wzx5stW0r4fF--
