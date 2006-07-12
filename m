Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWGLSGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGLSGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGLSGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:06:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:1889 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932275AbWGLSGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:06:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aHbOxWl6xnRcv+Z8YAPasWi2sv1RTnt/a0yVYZUDfP4iI4LiDgTyv/9XZztQXanytomqhirEzJAWSJg4UYJ69TZQWRT2I43QbaYgxcLB6EfcZe1t3fvHdHq/dmZvqEkGOOro4+iDMuSbTAsB72/fLEQ7K1oF6sqo9qCuHYpqmjQ=
Message-ID: <2c0942db0607121106mdce053ap2ea631486dca68f@mail.gmail.com>
Date: Wed, 12 Jul 2006 11:06:37 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: annoying frequent overcurrent messages.
Cc: "Dave Jones" <davej@redhat.com>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <Pine.LNX.4.44L0.0607121344420.6111-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2c0942db0607121034w170b4b24l928773fa37b3705e@mail.gmail.com>
	 <Pine.LNX.4.44L0.0607121344420.6111-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Then the logging of the 'all cleared up' message would be better if it
> > had a bit of hysteresis to it -- the good state is noticed, but don't
> > log it as such until it hangs out there for a while and has had a
> > chance to quiesce.
>
> You didn't read what I wrote -- there _is_ no "all cleared up" message.

You're right, I didn't -- my apologies. However:

> > That's almost exactly how the driver behaves currently -- the message is
> > printed just once when the state is first noticed.  Nothing is printed
> > when the state is cleared, and nothing gets printed repeatedly during the
> > problem period.  But then the problem recurs very quickly.

If you change my wording from "all cleared up message" to "clearing
the internal state that keeps track of whether we're still in an
overcurrent situation" then my suggestion still makes sense. In short,
don't believe we're out of the overcurrent state until a bit of time
passes.

Before we go any further, let's make sure my suggestion could even fix
anything for Dave. Dave? How often are these messages printed? Do they
come in clumps? Or are they periodic? In other words, would a bit of
hystersis in the state clearing code remove most of the messages for
you? Or am I just stirring up trouble?

Ray
