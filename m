Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWINPBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWINPBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWINPBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:01:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:38591 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWINPBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:01:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JaR+CHeF2R2cs32hF5sFzbr5CyIqj+XyXOusuwbZj+mPlrYTxwgpNoMUY3friFgGHumDxnWEfhl86QuhlQHaYG72kvAaC36SPW28a+6bszAGlNlPPu3+zmrTuSo4jpUIWp6vwi82XK2cSpeWDlOlItkybVBy/zYr8Q8eRzOREMM=
Message-ID: <787b0d920609140801r452ff7d7vdc2d96865836eefc@mail.gmail.com>
Date: Thu, 14 Sep 2006 11:01:46 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] i386/x86_64 signal handler arg fixes
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, hpa@zytor.com
In-Reply-To: <200609141211.53087.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>
	 <200609141211.53087.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Andi Kleen <ak@suse.de> wrote:
> On Thursday 14 September 2006 10:34, Albert Cahalan wrote:
>
> > For i386, the non-RT frame is wrong. It was using the raw sig value
> > instead of the translated value, and did not pass the semi-documented
> > extra parameters.
>
> The translation is not needed because x86-64 doesn't support iBCS at all
> and afaik it was only used for that.

I figured, but you already have part of the code it seems.
(messing around with current_thread_info()->exec_domain
to get ->signal_invmap)

I guess that should be deleted then?

Currently you remap signals. Whatever you do this for
regparm(0) should also be done for regparm(3).
