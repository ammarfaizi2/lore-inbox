Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUDFHFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbUDFHFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:05:10 -0400
Received: from holomorphy.com ([207.189.100.168]:41923 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263644AbUDFHE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:04:56 -0400
Date: Tue, 6 Apr 2004 00:03:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-ID: <20040406070342.GG791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com, akpm@osdl.org, colpatch@us.ibm.com
References: <20040329041253.5cd281a5.pj@sgi.com> <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com> <1081150967.20543.23.camel@bach> <20040405010839.65bf8f1c.pj@sgi.com> <1081227547.15274.153.camel@bach> <20040405230601.62c0b84c.pj@sgi.com> <40724CF4.5090705@yahoo.com.au> <20040405233415.2c7c3a96.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405233415.2c7c3a96.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
>> I like cpumask_t. 

On Mon, Apr 05, 2004 at 11:34:15PM -0700, Paul Jackson wrote:
> Ok - one vote for cpumask_t.
> I could go either way.  I see that 'struct foo' is more common than
> 'foo_t' in kernel code.
> I will not actually propose to change cpumask_t to 'struct cpumask'
> unless others want it.  Without a half-way decent reason, it would just
> be stupid churning.  But I wouldn't put up much resistance to such a
> change.

The reason this wasn't done up-front was that the presence of a "struct"
constructor in the type caused concern about the operational semantics of
argument-passing being less efficient as they would be for arithmetic
types. Since the type had to be (a) ambiguous and (b) potentially
arithmetic the typedef was mandated by this.

If the requirements for ambiguity and arithmetic types are lifted, this
would be possible.

If this makes you happier (though I can't imagine why SGI and you
aren't more concerned with functional or performance issues, e.g.
mmlist_lock or tasklist_lock contention, or headless node or mixed cpu
speed support, or fully automatic large TLB entry use / superpages)
then by all means. Just (a) be careful so you don't make things explode
for some arch; arches rely on this stuff so please run things by arch
maintainers when rearranging their code and (b) please, please, for the
love of $DEITY, **NOT** "struct cpumask_struct".


Nick wrote:
>> And you should not need to look inside it or use it with
>> anything other than using the cpumask interface, right?

On Mon, Apr 05, 2004 at 11:34:15PM -0700, Paul Jackson wrote:
> In my view, right - you (seldom) need to look inside.  From what I can
> make of Rusty's statements so far, he apparently has a different view ;).
> We'll see.

You should also bear in mind that the current implementations of these
operations use a macro calling convention, thereby altering their output
operands as a side-effect without call-by-reference. I've lost the
intestinal fortitude to investigate whether you already handled this,
but altering the calling convention to e.g. true call-by-value would
have to sweep all callers to act on the output operands compatibly anyway.


-- wli
