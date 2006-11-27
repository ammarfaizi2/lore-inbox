Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757272AbWK0Hv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbWK0Hv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 02:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757271AbWK0Hv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 02:51:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757269AbWK0Hv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 02:51:58 -0500
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
From: Arjan van de Ven <arjan@infradead.org>
To: Wink Saville <wink@saville.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4569EF9D.7010802@saville.com>
References: <fa./NRPJg+JjfSQLUVwnX1GpHGIojQ@ifi.uio.no>
	 <fa.Y0RKABHd+7qnbGQYBAGPvlJ0Qic@ifi.uio.no>
	 <fa.fD3WSpNqEJ4736vYzEak5Gf3xTw@ifi.uio.no>
	 <fa.A+gkQAO1DLThaxJxPLPl3yE1CGo@ifi.uio.no>
	 <fa.INurNKWdUKAEULTHyfpSW65a/Ng@ifi.uio.no>
	 <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no> <4569404E.20402@shaw.ca>
	 <45694D6F.60100@saville.com>
	 <1164529484.3147.68.camel@laptopd505.fenrus.org>
	 <4569EF9D.7010802@saville.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 27 Nov 2006 08:51:54 +0100
Message-Id: <1164613914.3276.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-26 at 11:48 -0800, Wink Saville wrote:
> Arjan van de Ven wrote:
> > it's the cost of a syscall (1000 cycles?) plus what it takes to get a
> > reasonable time estimate. Assuming your kernel has enough time support
> > AND your tsc is reasonably ok, it'll be using that. If it's NOT using
> > that then that's a pretty good sign that you can't also use it in
> > userspace....
> > 
> 
> I wrote a quick and dirty program that I've attached to test the cost
> difference between RDTSC and gettimeofday (gtod), the results:
> 
> wink@winkc2d1:~/linux/linux-2.6/test/rdtsc-pref$ time ./rdtsc-pref 100000000
> rdtsc:   average ticks=  65
> gtod:    average ticks= 222
> gtod_us: average ticks= 232

just to make sure, you do realize that when you write "ticks" that rdtsc
doesn't measure cpu clock ticks or cpu cycles anymore, right? (At least
not on your machine)


> But, there are other uses that it wouldn't be acceptable. For instance, I
> have used a memory mapped time stamp counter in an embedded ARM based

ARM is a different animal; generally on such embedded system you know a
lot better if you have a reliable and userspace-useful tick counter like
this....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

