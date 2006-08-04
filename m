Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWHDQUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWHDQUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWHDQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:20:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:52666 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161278AbWHDQUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:20:30 -0400
Message-ID: <44D373C3.2050909@sgi.com>
Date: Fri, 04 Aug 2006 18:20:19 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, ricknu-0@student.ltu.se,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>	 <44BE9E78.3010409@garzik.org>  <yq0lkq4vbs3.fsf@jaguar.mkp.net>	 <1154702572.23655.226.camel@localhost.localdomain>	 <44D35B25.9090004@sgi.com>	 <1154706687.23655.234.camel@localhost.localdomain>	 <44D36E8B.4040705@sgi.com> <1154709025.23655.246.camel@localhost.localdomain>
In-Reply-To: <1154709025.23655.246.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-04 am 17:58 +0200, ysgrifennodd Jes Sorensen:
>>> You don't use bool for talking to hardware, you use it for the most
>>> efficient compiler behaviour when working with true/false values.
>> Thats the problem, people will start putting them into structs, and
>> voila all alignment predictability has gone out the window.
> 
> Jes, try reading as well as writing. Given you even quoted "You don't
> use bool for talking to hardware" maybe you should read it.

Alan,

I did read, I never suggested putting it into structs describing
hardware registers.

> Structure alignment is generally a bad idea anyway because even array
> and word alignment are pretty variable between processors.

It's fairly common in drivers to layout things in effective ways in
structs relying on alignment. It can make a noticeable difference if
you get cacheline alignment wrong. For example in network drivers where
parts of the struct is used for receive and the other part is used for
transmit and the two parts can run in parallel on different CPUs.
Obviously one ends up using the aligned attribute, but the more one can
avoid adding those on in the struct the easier it is to maintain and
read.

Regards,
Jes

