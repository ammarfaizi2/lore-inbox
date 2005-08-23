Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVHWFw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVHWFw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 01:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHWFw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 01:52:29 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:11868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750735AbVHWFw2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 01:52:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EK0m/k1tPC+GiC+GlXAq49ZZNkt+LvOuCtVuYRl1RglJN9GdV/oN519aeFkmJ+EdWx0aU8kMWI3AdpaZghdSgQ3Ta9hyNpoNDZGvZHaGbSx2l44IEuVvxTLzsB75E8OokeQSuGujOb1U1/WedbttZXzLAaE/Z6KatAhFEITB9xk=
Message-ID: <a36005b505082222523f81453d@mail.gmail.com>
Date: Mon, 22 Aug 2005 22:52:27 -0700
From: Ulrich Drepper <drepper@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process (update)
Cc: e8607062@student.tuwien.ac.at, linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1124387342.16072.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1124326652.8359.3.camel@w2> <p7364u40zld.fsf@verdi.suse.de>
	 <1124381951.6251.14.camel@w2>
	 <1124387342.16072.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Perhaps those application authors should provide a management interface
> to do so within the soft limit range at least. Its not clear to me that
> growing the fd array on a process is even safe. Some programs do size
> arrays at startup after querying the rlimit data.

That's very true.  Using such a remote-rlimit syscall would break all
kinds of code.  It's a basic assumption from Unix/POSIX that the
limits remain constant.  And as Alan hinted at: this is why there are
soft and hard limits.  If tey are set to the same value you obviously
don't get anything.  But this is the application programmer's fault. 
An application which is aware of resources and tries to limit them
should set the soft limits to a reasonable low value and the hard
limit to the absolute maximum (probably the system's maximum).  Then
you can have remote procedure calls into the application to adjust the
soft limits.  Having to change the hard limit means the capacity
planning for the app is completely wrong.  A restart is certainly
acceptable in that case since it should really never happen.
