Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWGLAA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWGLAA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWGLAA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:00:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24555 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932276AbWGLAA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:00:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nM3zIuHaELJy/dKEaFxlTR/yd/fIY50hHojkiQllv8pWqddk7fygCcK6k2e5Mz/Oh9pK6x/atoidneJzLpNLMOqK1hhznWwJgBgYDc13+BumzLJVFVPrcPZ2HFyEVFyQCB+WwJi1HiJvEYEDt2FY/S8y2XjNR1bxPKBb/LodCns=
Message-ID: <9e4733910607111700p53697fc8x3f22c720ef0ea29a@mail.gmail.com>
Date: Tue, 11 Jul 2006 20:00:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: tty's use of file_list_lock and file_move
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Theodore Tso" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <44B43409.2020401@microgate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
	 <20060711012904.GD30332@thunk.org>
	 <20060711194456.GA3677@flint.arm.linux.org.uk>
	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com>
	 <1152657465.18028.72.camel@localhost.localdomain>
	 <44B43409.2020401@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Paul Fulghum <paulkf@microgate.com> wrote:
> Alan Cox wrote:
> > Ar Maw, 2006-07-11 am 18:08 -0400, ysgrifennodd Jon Smirl:
> >
> >>What about adjusting things so the BKL isn't required? I tried
> >>completely removing it and died in release_dev. tty_mutex is already
> >>locks a lot of stuff, maybe it can be adjusted to allow removal of the
> >>BKL.
> >
> >
> > Thats what is happening currently. However it is being done piece by
> > piece, slowly and carefully.
>
> I hate to chime in since I don't have time in the near term
> to contribute to the subject, but I do like the idea of removing
> the BKL dependence as a first step. I find its semantics akward to keep
> track of, and error prone. More explicit locking, even global, would clear things
> up for a later push to finer grained (per tty?) locking (where appropriate).
>
> Making the necessary changes to all the individual drivers,
> as Russel's comment about explicitly dropping the new lock when
> sleeping pointed out, would be a time consuming (and probably
> tedious) task.

I'm still looking at doing work in the tty layer but it is turning out
to be more complex that I initially thought. I may give removing the
BLK another attempt when I understand things better.

I have all of the lock debugging turned on in my kernel. I did get
nice messages when I did dumb things like sleeping with locks held or
deadlocking that led to quickly fixing the code. Much better than the
old system of freezing the box up.

-- 
Jon Smirl
jonsmirl@gmail.com
