Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWFBHc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWFBHc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFBHc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:32:28 -0400
Received: from mail.enyo.de ([212.9.189.167]:20669 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750865AbWFBHc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:32:27 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Brian F. G. Bidulock" <bidulock@openss7.org>
Subject: Re: Question about tcp hash function tcp_hashfn()
References: <20060531090301.GA26782@2ka.mipt.ru>
	<20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru>
	<20060531.114127.14356069.davem@davemloft.net>
	<20060601060424.GA28087@2ka.mipt.ru>
Date: Fri, 02 Jun 2006 07:40:38 +0200
In-Reply-To: <20060601060424.GA28087@2ka.mipt.ru> (Evgeniy Polyakov's message
	of "Thu, 1 Jun 2006 10:04:24 +0400")
Message-ID: <87y7wgaze1.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Evgeniy Polyakov:

> That is wrong. And I have a code and picture to show that, 
> and you dont - prove me wrong :)

Here we go:

static inline num2ip(__u8 a1, __u8 a2, __u8 a3, __u8 a4)
{
	__u32 a = 0;

	a |= a1;
	a << 8;
	a |= a2;
	a << 8;
	a |= a3;
	a << 8;
	a |= a4;

	return a;
}

"gcc -Wall" was pretty illuminating. 8-P After fixing this and
switching to a better PRNG, I get something which looks pretty normal.
