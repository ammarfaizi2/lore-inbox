Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUELVF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUELVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUELVCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:02:21 -0400
Received: from holomorphy.com ([207.189.100.168]:58297 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265227AbUELVBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:01:00 -0400
Date: Wed, 12 May 2004 13:59:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512205915.GJ1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	davidel@xmailserver.org, jgarzik@pobox.com, greg@kroah.com,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com> <20040512200305.GA16078@elte.hu> <20040512132050.6eae6905.akpm@osdl.org> <20040512203829.GI1397@holomorphy.com> <20040512134718.7e55cceb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512134718.7e55cceb.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> How about this?
>>  #if HZ <= 1000 && !(1000 % HZ)
>>  #define MSEC_TO_JIFFIES(m)	((1000/HZ)*(m))
>>  #define JIFFIES_TO_MSEC(j)	((j)/(1000/HZ))
>>  #elif HZ > 1000 && !(HZ % 1000)
>>  #define MSEC_TO_JIFFIES(m)	((m)/(HZ/1000))
>>  #define JIFFIES_TO_MSEC(j)	((HZ/1000)*(j))
>>  #else
>>  #define MSEC_TO_JIFFIES(m)	((HZ*(m) + 999)/1000)
>>  #define JIFFIES_TO_MSEC(j)	((1000*(j) + HZ - 1)/HZ)
>>  #endif

On Wed, May 12, 2004 at 01:47:18PM -0700, Andrew Morton wrote:
> You promise it's correct and generates good code?

Yes. Changelog:

Optimize the cases where HZ is a divisor of 1000 or vice-versa in
JIFFIES_TO_MSEC() and MSEC_TO_JIFFIES() by allowing the nonvanishing(!)
integral ratios to appear as a parenthesized expressions eligible for
constant folding optimizations.

I'll resend the #ifdef logic against Ingo's latest, which is orthogonal.


-- wli
