Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbVLGSKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbVLGSKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbVLGSKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:10:22 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45986 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751642AbVLGSKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:10:21 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <1133978128.2869.51.camel@laptopd505.fenrus.org>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <1133978128.2869.51.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 10:09:56 -0800
Message-Id: <1133978996.24344.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 18:55 +0100, Arjan van de Ven wrote:
> > > Many of the interesting places that deal with pids and where you
> > > want translation are not where the values are read from current->pid,
> > > but where the values are passed between functions.  Think about
> > > the return value of do_fork.
> > 
> > Exactly.  The next phase will focus on such places.  Hubertus has some
> > stuff working that's probably not ready for LKML, but could certainly be
> > shared.
> 
> hmm wonder if it's not just a lot simpler to introduce a split in
> "kernel pid" and "userspace pid", and have current->pid and
> current->user_pid for that.
> 
> Using accessor macros doesn't sound like it gains much here.. (but then
> I've not seen the full picture and you have)

My first instinct was to introduce functions like get_user_pid() and
get_kernel_pid() which would effectively introduce the same split.
Doing that, we could keep from even referencing ->user_pid in normal
code, and keep things small and simpler for people like the embedded
folks.

For the particular application that we're thinking of, we really don't
want "user pid" and "kernel pid" we want "virtualized" and
"unvirtualized", or "regular old pid" and "fancy new virtualized pid".

So, like in the global pidspace (which can see all pids and appears to
applications to be just like normal) you end up returning "kernel" pids
to userspace.  That didn't seem to make sense.  

-- Dave

