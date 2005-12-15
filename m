Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVLOVcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVLOVcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLOVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:32:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:48614 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751045AbVLOVco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:32:44 -0500
Date: Thu, 15 Dec 2005 21:32:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: JANAK DESAI <janak@us.ibm.com>, viro@ftp.linux.org.uk, chrisw@osdl.org,
       dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
Message-ID: <20051215213234.GB6990@mail.shareable.org>
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com> <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I follow but I am very disturbed.
> 
> You are leaving CLONE_NEWNS to mean you want a new namespace.
> 
> For clone CLONE_FS unset means generate an unshared fs_struct
>           CLONE_FS set   means share the fs_struct with the parent
> 
> But for unshare CLONE_FS unset means share the fs_struct with others
>             and CLONE_FS set   means generate an unshared fs_struct
> 
> The meaning of CLONE_FS between the two calls in now flipped,
> but CLONE_NEWNS is not.  Please let's not implement it this way.

I agree.

> Part of the problem is the double negative in the name, leading
> me to suggest that sys_share might almost be a better name.

I agree with that suggestion, too.

Alternatively, we could just add a flag to clone(): CLONE_SELF,
meaning don't create a new task, just modify the properties of the
current task.

> So please code don't invert the meaning of the bits.  This will
> allow sharing of the sanity checks with clone.
> In addition this leaves open the possibility that routines like
> copy_fs properly refactored can be shared between clone and unshare.

And also make the API less confusing to document and use.

-- Jamie
