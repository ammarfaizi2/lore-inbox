Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWH3Fbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWH3Fbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 01:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWH3Fbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 01:31:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:693 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964984AbWH3Fbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 01:31:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/nFFHxoujPAY31Nts/6+LxEZNM7f5uymNXzUYsd6vFhLOPGSSBSygiZFpsW8mSlg+u+8llkagWiYwSoHNz/a5dgP2P+MHXLIG+dPnK42sK+/wWlBdBKskXi8tHeVIj4yK9er6dIFHDB1CckmtFuJy08UK2fV1oTZ68v13yHqX4=
Message-ID: <b115cb5f0608292231r1a3c47c8r8980b32e838ff964@mail.gmail.com>
Date: Wed, 30 Aug 2006 11:01:43 +0530
From: "Rajat Jain" <rajat.noida.india@gmail.com>
To: "Rik van Riel" <riel@surriel.com>
Subject: Re: Spinlock query
Cc: "Rick Brown" <rick.brown.3@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F501B3.9070200@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7783925d0608291912i3f04d460kc9edebf9d358dbc3@mail.gmail.com>
	 <44F501B3.9070200@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, Rik van Riel <riel@surriel.com> wrote:
> Rick Brown wrote:
> > Hi,
> >
> > In my driver (Process context), I have written the following code:
> >
> > --------------------------------------------
> > spin_lock(lock)
> > ...
> > //Critical section to manipulate driver data
>
> ... interrupt hits here
>     interrupt handler tries to grab the spinlock, which is already taken
>     *BOOM*
>
> > spin_u lock(lock)
> > ---------------------------------------------
> >

The interrupt handler TRIES to grab the spinlock, which is already
taken. Why will it "BOOM"? Wouldn't the interrupt handler busy wait,
waiting for the lock?

Am I missing something here?

Rajat

> > I have written similar code in my interrupt handler (Interrupt
> > context). The driver data is not accessed from anywhere else. Is my
> > code safe from any potential concurrency issues? Is there a need to
> > use spin_lock_irqsave()? In both the places?
>
> You need to use spin_lock_irqsave() from process context.
>  From the interrupt handler itself it doesn't hurt, but it
> shouldn't matter much since interrupt handlers should not
> get preempted.
