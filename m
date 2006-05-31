Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWEaJv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWEaJv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEaJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:51:27 -0400
Received: from gw.openss7.com ([142.179.199.224]:36077 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S964931AbWEaJv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:51:26 -0400
Date: Wed, 31 May 2006 03:51:24 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531035124.B3065@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060530235525.A30563@openss7.org> <20060531.001027.60486156.davem@davemloft.net> <20060531014540.A1319@openss7.org> <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org> <20060531090301.GA26782@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060531090301.GA26782@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Wed, May 31, 2006 at 01:03:02PM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Wed, 31 May 2006, Evgeniy Polyakov wrote:
> 2. Compared Jenkins hash with XOR hash used in TCP socket selection code.
> http://tservice.net.ru/~s0mbre/blog/2006/05/14#2006_05_14

Two problems with the comparison:

  Port numbers can be collected into a 32 bit register in network
  byte order directly from the TCP packet without taking two 16 bit
  values and shifting and or'ing them.

  Worse: he folded the jenkins algorith result with

   h ^= h >> 16;
   h ^= h >> 8;

  Destroying the coverage of the function.

I, for one, am not suprised that artifacts appeared in the comparison
as a result of this destruction of the coverage of the hashing function.
