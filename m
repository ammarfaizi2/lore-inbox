Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266549AbSKGNhM>; Thu, 7 Nov 2002 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266550AbSKGNhM>; Thu, 7 Nov 2002 08:37:12 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:58103 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266549AbSKGNhL>;
	Thu, 7 Nov 2002 08:37:11 -0500
Date: Thu, 7 Nov 2002 08:43:46 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] read(2) and page aligned buffers
Message-ID: <20021107134346.GA25833@www.kroptech.com>
References: <20021107065421.20283.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107065421.20283.qmail@email.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 01:54:21AM -0500, Clayton Weaver wrote:
> Here is wrap_read() (assume that the appropriate #includes are there):

Your code is broken, and for exactly the same reason I told you
yesterday.

>       default: /* partial read */
> 	switch(errno) {
> 	case EINTR:    /* interrupted by signal */
> 	case EAGAIN:   /* O_NONBLOCK ? */
> 	  retval += tmpret;
> 	  break;

I repeat: Checking errno when read() has returned something other than
-1 is ILLEGAL. Period. This check is triggering early, thus giving your
supposed early EOF.

This is not even remotely a kernel issue.

--Adam
