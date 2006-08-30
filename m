Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWH3RkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWH3RkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWH3RkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:40:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36915 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751220AbWH3RkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P4Xoe5D3NBT7FmB1Hlu/UFj1xUKWeN+xlfoFL85Zoojhb5v84mgaOYW9xWic7ticjV+q1tQhql4zq9aWuFzFTkOVEJrXHEjGAETUvmdJ8bIrG7r4I0QkRiJG4DcSaEUetquIJxBZKoacU0frckFKEJ9h1d6SQ4vNCKcV02Nzo6M=
Message-ID: <6e0cfd1d0608301040kf347dc8w6088a1fc8cd8b2b1@mail.gmail.com>
Date: Wed, 30 Aug 2006 19:40:19 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "David Wagner" <daw-usenet@taverner.cs.berkeley.edu>
Subject: Re: [S390] cio: kernel stack overflow.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ed4gno$d29$1@taverner.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060830124047.GA22276@skybase>
	 <ed4gno$d29$1@taverner.cs.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, David Wagner <daw@cs.berkeley.edu> wrote:
> Have you checked that in all cases all fields of the struct have
> been overwritten?  For instance, look at this:
>
> Martin Schwidefsky  wrote:
> >-      chp->dev = (struct device) {
> >-              .parent  = &css[0]->device,
> >-              .release = chp_release,
> >-      };
> >+      chp->dev.parent = &css[0]->device;
> >+      chp->dev.release = chp_release;
>
> Doesn't this leave chp->dev.bus still holding whatever old value it
> had laying around before?  Unless I'm missing something, it looks to
> me like this diff causes a change in the semantics of the code.
>
> Perhaps it would be better to memset() the entire struct (chp->dev, in
> this case) to zero, before assigning to individual fields, so there is
> no possibility of old remnant data still being left laying around?

The structure is allocated with kzalloc().

-- 
blue skies,
  Martin
