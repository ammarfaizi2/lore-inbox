Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWGORBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWGORBt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGORBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:01:49 -0400
Received: from pat.uio.no ([129.240.10.4]:45503 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750720AbWGORBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:01:48 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	 <1152815391.7650.58.camel@localhost.localdomain>
	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	 <1152821011.24925.7.camel@localhost.localdomain>
	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	 <1152887287.24925.22.camel@localhost.localdomain>
	 <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	 <20060714162935.GA25303@sergelap.austin.ibm.com>
	 <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	 <1152896138.24925.74.camel@localhost.localdomain>
	 <20060714170814.GE25303@sergelap.austin.ibm.com>
	 <1152897579.24925.80.camel@localhost.localdomain>
	 <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	 <1152900911.5729.30.camel@lade.trondhjem.org>
	 <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
	 <1152911079.5729.70.camel@lade.trondhjem.org>
	 <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
	 <4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com>
	 <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 13:01:12 -0400
Message-Id: <1152982872.5715.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.355, required 12,
	autolearn=disabled, AWL 1.46, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
> I hope the confusion has passed for Trond.  My impression was he
> figured this was per process data so it didn't make sense any where
> near a filesystem, and the superblock was the last place it should
> be.

You are still using the wrong abstraction. Data that is not global to
the entire machine has absolutely _no_ place being put into the
superblock. It doesn't matter if it is process-specific,
container-specific or whatever-else-specific, it will still be vetoed.

If your real problem is uid/gid mapping on top of generic filesystems,
then have you looked into the *BSD solution of using a stackable
filesystem (i.e. umapfs)?

  Trond

