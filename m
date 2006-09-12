Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWILX6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWILX6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 19:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWILX6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 19:58:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:37544 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030395AbWILX6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 19:58:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iZ4MM0QGm+BTtYrPCxVZDIvT0YtOEr8GIpe5NzSrSEZW8iPH9CSIZkHEj6VfYyWYQTwI9r1CvDajTnTrm3lLLcauKcqGZmU3qoI0donQq9DM0ygjnFLYOEXBRsKtT7aMchySKrdLIi+CsiJITo4ACsCRawhdp41wfdDnW2CBhbY=
Message-ID: <5c49b0ed0609121658y6e96c4a7n46f1d68645f621b6@mail.gmail.com>
Date: Tue, 12 Sep 2006 16:58:06 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH 00/20] vm deadlock avoidance for NFS, NBD and iSCSI (take 7)
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "David Miller" <davem@davemloft.net>,
       "Rik van Riel" <riel@redhat.com>,
       "Daniel Phillips" <phillips@google.com>
In-Reply-To: <Pine.LNX.4.64.0609120935110.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912143049.278065000@chello.nl>
	 <Pine.LNX.4.64.0609120935110.27779@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 12 Sep 2006, Peter Zijlstra wrote:
> >
> > Linus, when I mentioned swap over network to you in Ottawa, you said it was
> > a valid use case, that people actually do and want this. Can you agree with
> > the approach taken in these patches?
>
> Well, in all honesty, I don't think I really said "valid", but that I said
> that some crazy people want to do it, and that we should try to allow them
> their foibles.
>
> So I'd be nervous to do any _guarantees_. I think that good VM policies
> should make it be something that works in general (the dirty mapping
> limits in particular), but I'd be a bit nervous about anybody taking it
> _too_ seriously. Crazy people are still crazy, they just might be right
> under certain reasonably-well-controlled circumstances.

(oops, forgot to cc: the list)

Personally, I'm a little unhappy with the added complexity here, I'm
not convinced that this extra feature is worth it.  In particular,
adding to the address_space_operations, the block_device_operations,
and creating a new swap index/offset interface just for this seems
questionable.  I feel like interface bloat should be reserved for
features that have widespread use and benefit.

Not that I'm opposed to this feature, just that I think this patch is
too invasive interface-wise.

NATE
