Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVCOP1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVCOP1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCOP1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:27:41 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:45724 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261316AbVCOP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:27:38 -0500
Message-ID: <4236FEE6.2020205@lsrfire.ath.cx>
Date: Tue, 15 Mar 2005 16:27:34 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
References: <1110771251.1967.84.camel@cube>	 <42355C78.1020307@lsrfire.ath.cx> <1110816803.1949.177.camel@cube>
In-Reply-To: <1110816803.1949.177.camel@cube>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Note that the admin hopefully does not normally run as root.
> The admin should be using a normal user account most of the
> time, to reduce the damage caused by his accidents.

Openwall and GrSecurity solved this by having a special group that can 
see everything, just like root.  E.g. we could add a proc.gid kernel 
boot option for that purpose.

> Even if the admin were not running as a normal user, it is
> expected that normal users can keep tabs on each other.
> The admin may be sleeping. Social pressure is important to
> prevent one user from sucking up all the memory and CPU time.

IANAL, but creating a user profile (who ran what when, used how many 
resources etc.) without the user's consent is illegal at least here in 
Germany.  As an admin I'd like to be able to prevent a user from even 
trying to spy on another user.

> Anything provided by traditional UNIX and BSD systems
> should be available. Users who want privacy can get their
> own computer. So, these need to work:
> 
> ps -ef
> ps -el
> ps -ej
> ps axu
> ps axl
> ps axj
> ps axv
> w
> top

If with "work" you mean "show info about all users" then the patch 
becomes pointless.  The programs "work" in the sense that they do *not* 
should "cloaked" processes, which is intended. :)

OK, I understand that you need to be able to turn this feature off and I 
also don't want non-root admins to suddenly go blind.  Would adding a 
proc.gid kernel parameter and an off-switch be sufficient for you?

Thanks,
Rene
