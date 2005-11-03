Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVKCA5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVKCA5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVKCA5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:57:32 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:59536 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030238AbVKCA5b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:57:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m/HKft/B3iich/HlYyPytYbIzCWfcsxXUeC4XGzrQDpptzlqqrZknSPDZ0+K8ke9iRJveD50813wxfgHL/+/NeKWXQzK7A8zIT/0a2+W3TgICSNOFKNEn2ayHXKpyCgU6UXot9VdnXZ6gBj5byYHg4CewtPc4SY4pyACAfID2hQ=
Message-ID: <1e62d1370511021657m4bb6de33ofeca1422a4bd497f@mail.gmail.com>
Date: Thu, 3 Nov 2005 05:57:31 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: "ppunnam@kent.edu" <ppunnam@kent.edu>
Subject: Re: send_sigqueue problem..
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1932830193449a.193449a1932830@kent.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1932830193449a.193449a1932830@kent.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, ppunnam@kent.edu <ppunnam@kent.edu> wrote:
>
> i am trying to use the linux signaling to signal a user process from
> the kernel..
> i require a reliable(without any signal loss) and fast signaling
> mechanism.
> i tried to use the send_sigqueue to send the signals...here what i did
>
> 1) creted the sigqueue structure using the sigqueue_alloc()..
> 2) called the send_sigqueue() function...
> it worked fine for some time(around 1000 sig) but after that
> sigqueue_alloc failing..may be becuse of not enough memory  available
> to allocate sigqueue..

Its obvious that if you allocate some-thing (like through
sigqueue_alloc) then you have to free that too (like through
sigqueue_free)

> i got few question about this..
>
> 1) does sigqueue structure need to be removed explisitly or it will be
> autometically cleared after the signal delivery (i did't used the
> sigqueue_free() becuse i dont know when the signal is deliverd).

yes, you have to remove the structure explicitly as you allocated it
by your-self ! And I think you can call sigqueue_free just after
calling send_sigqueue because the singals are delivered to the process
with the wake_up call and then you can remove your sigqueue structure
(I might be wrong as I am saying this by just going through the
send_sigqueue function, CMIIW)


> 2)there is any another way i can implement such a signaling mechanism.
>

I saw one simple way in signal.c file. send_sig function which sends
signal by-itself (means allocate sigqueue internally) see
http://lxr.linux.no/source/kernel/signal.c#L1249



--
Fawad Lateef
