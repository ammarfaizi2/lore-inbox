Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbVIZPyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbVIZPyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbVIZPye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:54:34 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:51904 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751648AbVIZPye convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:54:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dg+XlJm7A/hocXnnTGslS1o76XZFkChxAheVRUBCl7PhZENiOjOdvoKgsuFHg4p+neUQzfd5/PmEXE3IEhvEdmFL0ntDXmUDK77bzFsskhbBQ0VVQlRNIoT8CdCG7/Ci/iorHjqgHGL2IWMT/NkY+zPKXb4nYRg8bmuZ4JA5uHA=
Message-ID: <9e473391050926085476c1582d@mail.gmail.com>
Date: Mon, 26 Sep 2005 11:54:31 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: usb-snd-audio breakage
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050926150709.GB15781@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910509251927484a70c7@mail.gmail.com>
	 <9e4733910509251943277f077a@mail.gmail.com>
	 <20050926033805.GB22376@redhat.com>
	 <9e473391050926063264010349@mail.gmail.com>
	 <20050926150709.GB15781@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/05, Greg KH <greg@kroah.com> wrote:
> On Mon, Sep 26, 2005 at 09:32:43AM -0400, Jon Smirl wrote:
> > So module
>
> That's up to that maintainer.
>
> > and proc code
>
> That is not true at all.

In one of the older threads about this someone pointed out two places
in /proc where it is done too. I tried searching for the message but I
can't find it.

> > will strip white space, but sysfs won't strip white space. Where is
> > the consistency?
>
> If you want to strip whitespace for all of your subsystem's sysfs files,
> a single function call will do this.
>
> After thinking about this for a while, and seeing all of the different
> iterations that the sysfs-whitespace-cleanup patch went through, I do
> not want to add this to sysfs.  It is very easy to add this to a
> subsystem, or even provide a generic function to do this if you want to
> (I'd be glad to add that to the sysfs core) but it's not for the core of
> sysfs to do for all files.

I went through the iterations because I hadn't thought about the case
where people were assigning multi-line CR terminated values to sysfs
attributes and then using multiple reads to process the assignments
one line at a time. I had thought that sysfs was only supposed to
allow the assignment of single values.

--
Jon Smirl
jonsmirl@gmail.com
