Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVHDSsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVHDSsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVHDSsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:48:40 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:39947 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262621AbVHDSsE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:48:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GGxBAy74UQ+5qbKv7bUhidXJze/tGFIQN4pdNmK00mKXBTHL3JP1gDnaMsSuPO/apUQGbG6d3Q0ERF5zLioYcVrWPUV/5GCJmPsssJVKcIDxcF2NgFzz5QyPQfkee1Aj5Wj77Ucjltls5siD2Lbbq1CcFyllwv/vYIpkvfZHNyA=
Message-ID: <29495f1d0508041148f9bb1fa@mail.gmail.com>
Date: Thu, 4 Aug 2005 11:48:04 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: george@mvista.com
Subject: Re: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
In-Reply-To: <42F24643.7080702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0507231456000.3728@scrub.home>
	 <20050723191004.GB4345@us.ibm.com>
	 <Pine.LNX.4.61.0507232151150.3743@scrub.home>
	 <20050727222914.GB3291@us.ibm.com>
	 <Pine.LNX.4.61.0507310046590.3728@scrub.home>
	 <20050801193522.GA24909@us.ibm.com>
	 <Pine.LNX.4.61.0508031419000.3728@scrub.home>
	 <20050804005147.GC4255@us.ibm.com> <20050804051434.GA4520@us.ibm.com>
	 <42F24643.7080702@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, George Anzinger <george@mvista.com> wrote:
> Uh... PLEASE tell me you are NOT changing timespec_to_jiffies() (and
> timeval_to_jiffies() to add 1.  This is NOT the right thing to do.  For
> repeating times (see setitimer code) we need the actual time as we KNOW
> where the jiffies edge is in the repeating case.  The +1 is needed ONLY
> for the initial time, not the repeating time.

Please read the patch. I didn't touch timespec_to_jiffies() or
timeval_to_jiffies(). Not sure why you think I did. I agree that we
only need the initial time, my patch is no good. But it is hard for
non-itimers, like schedule_timeout() callers, to provide an interface
that only adds 1 to the initial request, since the callers currently
pass in an absolute jiffies value.

Thanks,
Nish
