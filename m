Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWCXRhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWCXRhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWCXRhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:37:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:37084 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751281AbWCXRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:37:53 -0500
X-Authenticated: #271361
Date: Fri, 24 Mar 2006 18:37:42 +0100
From: Edgar Toernig <froese@gmx.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: lkml <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: delay_tsc(): inefficient delay loop (2.6.16-mm1)
Message-Id: <20060324183742.1b1986d1.froese@gmx.de>
In-Reply-To: <20060324170436.GA1568@rhlx01.fht-esslingen.de>
References: <20060324170436.GA1568@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
>
>  	rdtscl(bclock);
> +	/* offset with bclock to have very simple comparison below */
> +	loops += bclock;
>  	do {
>  		rep_nop();
>  		rdtscl(now);
> -	} while ((now-bclock) < loops);
> +	} while (now < loops);
>  }

Hehe, optimizing delay loops *g*  But your optimization is
wrong.  'loops+bclock' and/or 'now' is likely to wrap around
and then the test condition becomes bogus.

Ciao, ET.
