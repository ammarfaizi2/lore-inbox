Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWGNSP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWGNSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWGNSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:15:28 -0400
Received: from pat.uio.no ([129.240.10.4]:53142 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422650AbWGNSP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:15:28 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
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
Content-Type: text/plain
Date: Fri, 14 Jul 2006 14:15:11 -0400
Message-Id: <1152900911.5729.30.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.835, required 12,
	autolearn=disabled, AWL 1.17, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 11:36 -0600, Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > On Fri, 2006-07-14 at 12:08 -0500, Serge E. Hallyn wrote:
> >> yes, of course, vfsmount, which I assume is what Eric meant?
> >> 
> >> Which means we'd have to do this at permission() using the nameidata, or
> >> pass nd to generic_permission. 
> >
> > Yeah, I think so.  But, this is well into Al territory, and there might
> > be a better way.
> 
> Well until we get that sorted out I will keep picking on i_sb.

Don't bother: labelling superblocks with process-specific data is always
going to be unacceptable.

In order to avoid aliased superblocks, you would have to be able
guarantee to be the sole owner of the data on the device that it refers
to. You'd have to own the device in order to do that, in which case you
are better off just labelling the device instead.

Cheers,
  Trond

