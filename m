Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWDYSEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWDYSEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDYSEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:04:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:59823 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932113AbWDYSEG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:04:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dyoEn/DYLBVfCV/DZIh4K70sh83+45cV8+C0dqlDEfcnzgjI9OVpKKZDN9rJxMEVUxARgjYO6V4SmwJVKfiiQ5GDjFL8Lb49sU819vWSy0Aj3Go/3tTpI/iVnq8egsPv5VJo3+IaPgzhiDXhlqb44S1ATeW4qbc2R5W1RzVaL8k=
Message-ID: <d120d5000604251104k6867e51pb0a400d8f6dc3316@mail.gmail.com>
Date: Tue, 25 Apr 2006 14:04:06 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <444E61FD.7070408@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
	 <444DCAD2.4050906@argo.co.il>
	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
	 <444E524A.10906@argo.co.il>
	 <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>
	 <444E5A3E.1020302@argo.co.il>
	 <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
	 <444E61FD.7070408@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Avi Kivity <avi@argo.co.il> wrote:
> Dmitry Torokhov wrote:
> >>>>>
> >>>> No, it's optimized out. gcc notices that &lock doesn't change and that
> >>>> 'l' never escapes the function.
> >>>>
> >>>>
> >>> "l" that propects critical section gets thrown away???
> >>>
> >> Calm down, the storage for 'l' is thrown away, but its effects remain.
> >>
> >
> > Would you mind explaining implemenation details a little bit?
> >
> (I don't know how familiar you are with C++ so I'm explaining it from
> the basics, apologies if I'm repeating things you know)
>
> Very often one needs to acquire a resource, do something with it, and
> then free the resource. Here, "resource" can mean a file descriptor, a
> reference into a reference counted object, or, in our case, a spinlock.
> And we want "free" to mean "free no matter what", e.g. on a normal path
> or an exception path.
>
> In C++, you code it as a guard object:
>
> struct spinlock_guard {
>    spinlock_guard(spinlock_t *lock) { sl = lock; spin_lock(sl); }
>    ~spinlock_guard() { spin_unlock(sl); }
>
>    spinlock_t *sl;
> };
>

Oh, I remember now - lock is external wrt the code block it protects
so you just ensure destructor is called at the exit w/o allocating any
actual storage.
Thanks.

--
Dmitry
