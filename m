Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030816AbWKOS2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816AbWKOS2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030817AbWKOS2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:28:38 -0500
Received: from gw.goop.org ([64.81.55.164]:29338 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030816AbWKOS2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:28:37 -0500
Message-ID: <455B5C54.1050301@goop.org>
Date: Wed, 15 Nov 2006 10:28:36 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <20061115173252.GA24062@elte.hu> <455B557C.7020602@goop.org> <200611151905.04712.dada1@cosmosbay.com>
In-Reply-To: <200611151905.04712.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> I have the feeling (most probably wrong, but I prefer to speak than keeping 
> this for myself) that the cost of segment load is delayed up to the first use 
> of a segment selector. Sort of a lazy reload...
>   

Probably not too much, since the load itself has to raise a fault if
there's any problem with the segment itself, and once it is loaded you
can change the underlying descriptor without affecting the segment
register. Even if it were lazy, that would only make the first %gs use a
bit slow, and shouldn't affect the subsequent ones.  However, when I
measured segment register use timings, I didn't see any dramatic costs
associated with segment register use which would account for a 5% hit in
your benchmark.

    J
