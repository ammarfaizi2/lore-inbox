Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWINS4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWINS4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWINS4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:56:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:49499 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751028AbWINS4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:56:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a0V2a1/kRTlY9016k+dMZ/dFoSkeIkcnHTeElaY7Y7c+t3zKXQUAWmP3TBr/Zk29V3Ad0KGnNoR7SSQy0eeci6b7tczDC/1wctBSj5MiLAyq+IG46S0tYTmoA2X4bB5Tf+Vv0sweYwQ1Ui+RVHbnfJydvGX85nZ2HbFXR5Fr+D0=
Message-ID: <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
Date: Thu, 14 Sep 2006 14:56:09 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
	 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
	 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
	 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
	 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
	 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Thu, 14 Sep 2006, Dmitry Torokhov wrote:
>
> > Well, we do not really care about nestiness do we? What we trying to
> > achieve is to teach lockdep that 2 locks while appear as the lame lock
> > in fact are different and protect 2 different structures. Ideally
> > lockdep should track every lock individually (based for example on its
> > address) but that would be too taxing so we need to help it. In your
> > implementation you embed this data into structure/code using lock, but
> > this information could be instilled into the lock itself upon
> > initialization and spin_[un]lock() implementation could be taught to use
> > this data thus making specialized spin_[un]lock*_nested() functions
> > unnecessary.
>
> Hi Dmitry,
>
> IMHO this is exactly what the nested locking primitives were introduced in
> lockdep for (we even have natural hierarchy here), so I am not sure if
> this is compliant with lockdep design. I definitely could do a patch that
> would introduce {spin,mutex..}_lock_init_subclass(), which would
> initialize the lock together with defining it's 'class', so that it could
> be distinguishable from any other lock of the same type during proving of
> correctness ... but this is a step towards distinguishing every single
> lock from all others (even of a same type), which I am not sure is the
> right direction.
>

I think it is - as far as I understand the reason for not tracking
every lock individually is just that it is too expensive to do by
default.

-- 
Dmitry
