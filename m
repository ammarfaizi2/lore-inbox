Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCOTy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCOTy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVCOTw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:52:56 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:63960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261819AbVCOTrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:47:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ikt9dkYig4xliCvHMp6U0HYrIM5ECjIKGOF4IR4w8sxARqjxFW8RAtkqnZ57FfsQO5P+5TI42bJUCiASoVO0ntV3h+yX4kFNor0dx90ylgI8YH6+ZJBYqorkTdoRPomXtZSumZ3a24vRnJOQG52QjJn7xLIer8ua0sJbSiXS9XQ=
Message-ID: <d120d50005031511476e65f68a@mail.gmail.com>
Date: Tue, 15 Mar 2005 14:47:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050315193415.GA26299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
	 <d120d500050315094724938ffc@mail.gmail.com>
	 <20050315193415.GA26299@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 11:34:15 -0800, Greg KH <greg@kroah.com> wrote:
> On Tue, Mar 15, 2005 at 12:47:38PM -0500, Dmitry Torokhov wrote:
> > Hi Greg,
> >
> > On Tue, 15 Mar 2005 09:08:34 -0800, Greg KH <greg@kroah.com> wrote:
> >
> > > So I'll be slowly converting the kernel over to using this new
> > > interface, and when finished, I can get rid of the old class apis (or
> > > actually, just make them static) so that no one can implement them
> > > improperly again...
> >
> > I disagree with this last step. What I liked about the driver model is
> > that once you convert (properly) subsystem to using it you
> > automatically get your proper refcounting and memory gets released at
> > proper time. The change as it proposed disconnects class device
> > instance from the meat so separate refcounting implementation
> > isneeded. This increases maintenance costs.
> 
> I agree.  The big point is that "properly" statement.  _Everyone_ gets
> this wrong the first time they do it.  And the second.  Hopefully, if
> they are persistant enough, the third time they get closer, and so on...
> 
> We need to make the driver model interface easier to use.  The class
> code is used by more individual drivers than the struct device, so
> that's the first place to make these kinds of changes, as it is the most
> necessary.
> 
> > I always viewed class_simple as a stop-gap measure to get hotplug
> > events in place until proper implementation is done. Please leave the
> > original interface in place so it can still be used if one wshes to do
> > so.
> 
> No, no one has so far done the "proper implementation" and I don't blame
> them.  It's not simple, and it gives them a very low payback for their
> time.  The old interface is good and powerful and hard to use.
> 

It takes only one proper implementation and the rest will follow. If
buses and devices can be implemented properly so can be calss_devices.
There is nothing magic about them.

Besides, if you divorce class device and the "meat" like that most of
the time you just ignoring the same problems that exist with the
"meat". Class is not useful by itself, it is additional attributes and
such that gets used. And with additional attributes you again have
your lifetime rules, refounting and such. In effect the change does
not buy you anything unless class interface is extremely limited.

-- 
Dmitry
