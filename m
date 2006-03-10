Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWCJNT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWCJNT7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWCJNT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:19:59 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:61131 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750961AbWCJNT6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:19:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dKT7poYOKLoowmwT3jq3nzp6UYq7I56vL41hPlR2ihwYe/aKN34UfQDjpTra+jBwJIMxKlrwfN0waIcXCU/h8dTuw3BT4QGrZe8ms3kK8eN+P1ND7XXf/F6/q9R1Ol9rkL9lSp3DvidXPHuURpjDenxnreH460Vz1TrJmvKfm+s=
Message-ID: <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
Date: Fri, 10 Mar 2006 14:19:55 +0100
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Cc: "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <1141977139.2876.15.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <1141977139.2876.15.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > Apply on top of 2.6.16-rc5.
> >
> > Comments?
>
>
> my big worry with a split LRU is: how do you keep fairness and balance
> between those LRUs? This is one of the things that made the 2.4 VM suck
> really badly, so I really wouldn't want this bad...

Yeah, I agree this is important. I think linux-2.4 tried to keep the
LRU list lengths in a certain way (maybe 2/3 of all pages active, 1/3
inactive). In 2.6 there is no such thing, instead the number of pages
scanned is related to the current scanning priority.

My current code just extends this idea which basically means that
there is currently no relation between how many pages that sit in each
LRU. The LRU with the largest amount of pages will be shrunk/rotated
first. And on top of that is the guarantee logic and the
reclaim_mapped threshold, ie the unmapped LRU will be shrunk first by
default.

The current balancing code plays around with nr_scan_active and
nr_scan_inactive, but I'm not entirely sure why that logic is there.
If anyone can explain the reason behind that code I'd be happy to hear
it.

Thanks,

/ magnus
