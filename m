Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136510AbREDVNw>; Fri, 4 May 2001 17:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136513AbREDVNr>; Fri, 4 May 2001 17:13:47 -0400
Received: from dsl081-246-098.sfo1.dsl.speakeasy.net ([64.81.246.98]:26120
	"EHLO are.twiddle.net") by vger.kernel.org with ESMTP
	id <S136510AbREDVMt>; Fri, 4 May 2001 17:12:49 -0400
Date: Fri, 4 May 2001 14:12:40 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010504141240.A11122@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, May 03, 2001 at 07:47:47PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 07:47:47PM +0400, Ivan Kokshaysky wrote:
>  - removed some mb's for non-SMP

This isn't correct.  Either you need atomic updates or you don't.
If you don't, then you shouldn't be using ll/sc at all.  If you do
(perhaps to coordinate with devices) then the barriers are required.

>  - removed non-inline up()/down_xx() when semaphore/waitqueue debugging
>    isn't enabled.

They should still be exported for module compatibility.


r~
