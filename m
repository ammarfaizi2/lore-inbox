Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVDROsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVDROsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 10:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVDROsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 10:48:12 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:48937 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262088AbVDROsF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 10:48:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m4s06fGk9YPefWMhR/8CdNL7tjrs42HLk3dof2gxh8qrdLI75TS6VuwZ073OSQ6L9T7/qLRL3T/r6B/1zMKWIwkFiF11JpCgtLNAuOZqOZHQ5VWWjxyjFs2coCLGy5z7az9Bmyiaf0EgRoUqyXL0uhnPuUGJRqbnBpuOYIzkR1o=
Message-ID: <6533c1c905041807487a872025@mail.gmail.com>
Date: Mon, 18 Apr 2005 10:48:03 -0400
From: Igor Shmukler <igor.shmukler@gmail.com>
Reply-To: Igor Shmukler <igor.shmukler@gmail.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: intercepting syscalls
Cc: Daniel Souza <thehazard@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
	 <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik, (and everyone),

Everything is IMHO only.

It all boils down to whether:
1. it is hard to correctly implement such LKM so that it can be safely
loaded and unloaded and when these modules are combined they may not
work together until there is an interoperability workshop (like the
one networking folks do).
2. it's not possible to do this right, hence no point to allow this in
a first place.

I am not a Linux expert by a long-shot, but on many other Unices it's
being done and works. I am only asking because I am involved with a
Linux port.

I think if consensus is on choice one, then hiding the table is a
mistake. We should not just close  abusable interfaces. Rootkits do
not need these, and if someone makes poor software we do not have to
install it.

Intercepting system call table is an elegant way to solve many
problems. Any driver software has to be developed by expert
programmers and can cause all the problems imaginable if it was not
down right.

Again, it's all IMHO. Nobody has to agree.

Igor

On 4/18/05, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 15 Apr 2005, Igor Shmukler wrote:
> 
> > Thank you very much. I will check this out.
> > A thanks to everyone else who contributed. I would still love to know
> > why this is a bad idea.
> 
> Because there is no safe way in which you could have multiple
> of these modules loaded simultaneously - say one security
> module and AFS.  There is an SMP race during the installing
> of the hooks, and the modules can still wreak havoc if they
> get unloaded in the wrong order...
> 
> There just isn't a good way to hook into the syscall table.
> 
> --
> "Debugging is twice as hard as writing the code in the first place.
> Therefore, if you write the code as cleverly as possible, you are,
> by definition, not smart enough to debug it." - Brian W. Kernighan
>
