Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUIUJes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUIUJes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267540AbUIUJes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:34:48 -0400
Received: from holomorphy.com ([207.189.100.168]:34501 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267535AbUIUJer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:34:47 -0400
Date: Tue, 21 Sep 2004 02:33:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
Message-ID: <20040921093316.GG9106@holomorphy.com>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F560E.7060207@sgi.com> <20040920223742.GA7899@wotan.suse.de> <414F8424.5080308@sgi.com> <20040921091353.GG8058@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921091353.GG8058@wotan.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 08:30:12PM -0500, Ray Bryant wrote:
>> I'm sorry if this is confusing, personal terminology usually gets in the 
>> way.
>> The idea is that just like for the page allocation policy (your current 
>> code), if you wanted, you would have a global, default page cache 
>
On Tue, Sep 21, 2004 at 11:13:54AM +0200, Andi Kleen wrote:
> Having both a per process page cache and a global page cache policy
> would seem like overkill to me.
> And having both doesn't make much sense anyways, because when the 
> system admin wants to change the global policy to free memory
> on nodes he would still need to worry about conflicting per process policies 
> anyways. So as soon as you have process policy you cannot easily
> change global anymore.

Ray, would being able to change the default policy via kernel command-
line options (and perhaps sysctl) suffice? It seems that a global
default and some global state (e.g. per-cpu state) should largely
capture what you're after. If not, could you clarify where it doesn't?

Also, this switch statement stuff is getting a little hairy; maybe
it's time to bring in mempolicy_ops. Or at least trudging through the
switch () statements is turning into a moderate amount of work for me.


-- wli
