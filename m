Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318350AbSGRUfB>; Thu, 18 Jul 2002 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSGRUfA>; Thu, 18 Jul 2002 16:35:00 -0400
Received: from holomorphy.com ([66.224.33.161]:27276 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318350AbSGRUeI>;
	Thu, 18 Jul 2002 16:34:08 -0400
Date: Thu, 18 Jul 2002 13:37:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718203703.GT1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
	jsimmons@transvirtual.com
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk> <20020718010617.GL1096@holomorphy.com> <20020718142946.L13352@parcelfarce.linux.theplanet.co.uk> <20020718201857.GS1096@holomorphy.com> <20020718213208.P13352@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020718213208.P13352@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 01:18:57PM -0700, William Lee Irwin III wrote:
>> This is the 4th one of these I've seen in the last two days. Any chance
>> of being able to compile with -g and get an addr2line on the EIP? I've
>> tried to reproduce it myself, but haven't gotten it to happen yet.

On Thu, Jul 18, 2002 at 09:32:08PM +0100, Matthew Wilcox wrote:
> seems fairly obvious what's happening with a couple of printks...
> printk("visual_init: sw = %p, conswitchp = %p, currcons = %d, init = %d\n",
>                     sw, conswitchp, currcons, init);
> gets me the interesting fact that sw & conswitchp are both NULL.
> later on, we call:
>     sw->con_init(vc_cons[currcons].d, init);
> which seems like it would be the exact cause, no?

Ugh, I should have been able to see this somehow...

On Thu, Jul 18, 2002 at 09:32:08PM +0100, Matthew Wilcox wrote:
> now whether putting a:
> 	if (!sw)
> 		return;
> call into visual_init or whether we should determine earlier never to
> call visual_init, I don't know.  The people who know about the console
> have been conspicuously silent so far...

To heck with waiting for them, if you can't boot because of it, I'd say
push the patch.


Cheers,
Bill
