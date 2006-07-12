Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWGLRer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWGLRer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWGLRer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:34:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31964 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932150AbWGLRer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:34:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1/u3o/4vrvsbY7grywKHBSH6TKplbJSeTBJgebhys6d+h7rQ/Rn6ow/TSkXE8+Aqu2+YAnPTcC34LU7L7Lxr/D7p7BkWwNdBDXcfiJfnRbMNirHcuHfltHNgCqiBjTKj5zYj4C+5rjcSMbUrATpxeXWzbQmAx7N1ZxBQu/6u7A=
Message-ID: <2c0942db0607121034w170b4b24l928773fa37b3705e@mail.gmail.com>
Date: Wed, 12 Jul 2006 10:34:45 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: annoying frequent overcurrent messages.
Cc: "Dave Jones" <davej@redhat.com>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2c0942db0607121009l1fc00764ye0b98d686700a74c@mail.gmail.com>
	 <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 12 Jul 2006, Ray Lee wrote:
>
> > On 7/12/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Dave Jones wrote:
> > > > I have a box that's having its dmesg flooded with..
> > > >
> > > > hub 1-0:1.0: over-current change on port 1
> > > > hub 1-0:1.0: over-current change on port 2
> > > > hub 1-0:1.0: over-current change on port 1
> > > > hub 1-0:1.0: over-current change on port 2
> > > ...
> > >
> > > > over and over again..
> > > > The thing is, this box doesn't even have any USB devices connected to it,
> > > > so there's absolutely nothing I can do to remedy this.
> > >
> > > Since you're not using the UHCI controller on that computer, you could
> > > simply rmmod uhci-hcd (or modify /etc/modprobe.conf to prevent it from
> > > being loaded in the first place).  That would stop the constant interrupts
> > > and the syslog spamming.
> >
> > For the syslog spamming, you could jus emit the message once when the
> > state is first noticed, then emit a everything good message when it
> > clears up. There's no need to log it repeatedly during the problem
> > period.
>
> That's almost exactly how the driver behaves currently -- the message is
> printed just once when the state is first noticed.  Nothing is printed
> when the state is cleared, and nothing gets printed repeatedly during the
> problem period.  But then the problem recurs very quickly.

Then the logging of the 'all cleared up' message would be better if it
had a bit of hysteresis to it -- the good state is noticed, but don't
log it as such until it hangs out there for a while and has had a
chance to quiesce.

Ray
