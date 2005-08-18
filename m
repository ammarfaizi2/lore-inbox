Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVHRRjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVHRRjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHRRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:39:36 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:42206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932343AbVHRRjg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:39:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATBT28BwAfDqmb9Wwvvq2GFEiopTfcMPcH0mxKPEMF1/81XO2RKR3QzqbmVmCAdegz70LYWF6jm831+N8R0f/2I5EZYPLew2hahAFHvAYbq2djo/Pfi5PGLr07UOdY3/AEI+Ui7iGpvtG9JhwvTZhXf10VlVgFwCilqLRt+xz7w=
Message-ID: <a762e24050818103979fea1ce@mail.gmail.com>
Date: Thu, 18 Aug 2005 10:39:33 -0700
From: Keith Mannthey <kmannth@gmail.com>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Subject: Re: Debugging kernel semaphore contention and priority inversion
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0830FCD7@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21FFE0795C0F654FAD783094A9AE1DFC0830FCD7@cof110avexu4.global.avaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> > From: Keith Mannthey [mailto:kmannth@gmail.com]
> > Sent: Wednesday, August 17, 2005 5:33 PM
> >
> > On 8/17/05, Davda, Bhavesh P (Bhavesh) <bhavesh@avaya.com> wrote:
> > > Is there a way to know which task has a particular (struct
> > semaphore
> > > *) down()ed, leading to another task's down() blocking on it?
> >
> > I would add a field to struct semaphore that tracks the
> > current process.
> > In your various up and downs have that field tracks the
> > "current" process.
> 
> Yeah, I thought about that. Unfortunately, it doesn't meet my need for
> not Heisenberg'ing the system. I can't instrument the struct semaphore
> {} in a running system.

  What kernel are you using?

  Can you do some form of a crash dump (maybe some diskdump thing)? 
It is hard to debug without insturmentation of some kind....  You are
most likely going to have to rebuild/change your current kernel to
sort this issue out....
 
> > This way you dump the semaphore you can see what task it is
> > holding it.  Have the module dump the semaphore and you can
> > id the task
> >
> > > It would be helpful to get a kernel stacktrace for the culprit too.
> >
> > Have you tried sysrq t?  See the Documentation/sysrq.txt file.
> 
> This is a headless system.

  How do you know you are spinning on some inode semaphore?  If the
system is only headless how do you know you are dealing with some
priority inversion issue?  Maybe the system has a panic or ????

  It seems to me you might be jumping to conclusions.  
 
> >
> > How stuck is the system?
> >
> > Keith
> 
> Very. Only pingable, but can't login via telnet/ssh/anything. Reason is
> the same reason the low priority mystery task is unable to run and
> release the held semaphore.

  From the present state you have described you would be unable to
load a module or interact with the box in anyway. It is really hard to
debug a kernel without a console.  As others have suggested a serial
console/net console would help a bunch.

Good luck!

Keith
