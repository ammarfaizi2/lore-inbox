Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVLPOcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVLPOcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVLPOcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:32:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:11195 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932310AbVLPOcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:32:04 -0500
Date: Fri, 16 Dec 2005 08:32:01 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: JANAK DESAI <janak@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, viro@ftp.linux.org.uk,
       chrisw@osdl.org, dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
Message-ID: <20051216143201.GA6466@sergelap.austin.ibm.com>
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com> <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com> <43A24362.6000602@us.ibm.com> <20051216105048.GA32305@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216105048.GA32305@mail.shareable.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jamie Lokier (jamie@shareable.org):
> Like clone(), unshare() will have to change from year to year, as new
> flags are added.  It would be good if the default behaviour of 0 bits
> to unshare() also did the right thing, so that programs compiled in
> 2006 still function as expected in 2010.  Hmm, this
> forward-compatibility does not look pretty.

This is a very good point, which I didn't quite appreciate at first.

I suppose it would be a bad idea to define a new set of unshare flags,
and have unshare use UNSH_NS | UNSH_FS ?  Then clone() could do the
proper translation from CLONE_* to UNSH_*, and call unshare after the
clone().  It still requires more work as clone() is maintained, but
at least it won't be as confusing as you've shown the current case to
be.

-serge
