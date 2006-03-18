Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWCRUpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWCRUpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWCRUpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:45:41 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:41659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750972AbWCRUpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:45:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h7tLJ7Fuv3mN7oXRF89pLtJOxc81jf2qkDupsF9HWphxVqMB073ARBQKIXvmn7hyrA9BCiGexLKvf/6PXZ9kpxge3BoglXgFeGMMKumpKUqFS78OYZcLsIWsU9CevMgKpPYgYa5QqLm6u4y6XWOJxnt7siBn/7WAUz8R6wvIYGM=
Message-ID: <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com>
Date: Sat, 18 Mar 2006 21:45:40 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
In-Reply-To: <20060318123102.7d8c048a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
	 <1142712975.17279.131.camel@localhost.localdomain>
	 <20060318123102.7d8c048a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Andrew Morton <akpm@osdl.org> wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, 2006-03-18 at 12:07 -0800, Andrew Morton wrote:
> >
> > > From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
> > > rather than rejecting it.  And I think 2.6.13 did that too.
> > >
> > > It would be bad of us to change this behaviour, even if that's what the
> > > spec says we should do - because we can break existing applications.
> > >
> > > So I think we're stuck with it - we should normalise and then accept such
> > > timevals.  And we should have a big comment explaining how we differ from
> > > the spec, and why.
> >
> > Hmm. How do you treat a negative value ?
> >
>
> In the same way as earlier kernels did!
>
> Unless, of course, those kernels did something utterly insane.  In that
> case we'd need to have a little think.
>

If the change only affects buggy apps (as Thomas says), then it seems
completely obvious to me that the change should be made.

1. We'll be in compliance with the spec
2. Buggy applications will actually be helped by this by getting a
clear error instead of undefined behaviour silently hiding the fact
that they are buggy.
3. Correct applications are unaffected.

Seems like a no-brainer to me...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
