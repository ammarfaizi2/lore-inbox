Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUINIMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUINIMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUINIJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:09:25 -0400
Received: from holomorphy.com ([207.189.100.168]:57745 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269199AbUINIBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:01:47 -0400
Date: Tue, 14 Sep 2004 01:01:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040914080132.GJ9106@holomorphy.com>
References: <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch> <20040909212507.GA32276@k3.hellgate.ch> <1094942212.1174.20.camel@cube> <20040914064403.GB20929@k3.hellgate.ch> <20040914071058.GH9106@holomorphy.com> <20040914075508.GA10880@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914075508.GA10880@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 00:10:58 -0700, William Lee Irwin III wrote:
>> The concern appears to be that the tools might interpret failed
>> permission checks as indications of process nonexistence. I don't
>> regard this as particularly pressing, as properly-written apps should
>> check the specific value of errno (in particular to retry when EAGAIN
>> is received in numerous contexts).

On Tue, Sep 14, 2004 at 09:55:08AM +0200, Roger Luethi wrote:
> I would expect a tool to refrain from asking for fields with restricted
> access if it needs a complete overview over existing processes. It can
> always ask for restricted fields in a second request (the vast majority
> of fields are world-readable anyway).

That expectation can't be entirely relied upon, as the restrictions may
not be predictable.


On Tue, 14 Sep 2004 00:10:58 -0700, William Lee Irwin III wrote:
>> Distinguishing between EPERM, ENOSYS, ENOENT, etc. could probably be
>> done if the fields are measured in units such that the top bit is never
>> set for any feasible value, then a fully qualified error return could
>> simply be returned as (unsigned long)(-err). I suspect VSZ may be
>> problematic wrt. overflows even for 32-bit, not just for 31-bit.

On Tue, Sep 14, 2004 at 09:55:08AM +0200, Roger Luethi wrote:
> Yeah, that makes me nervous. There are just too many ways this can go
> wrong or be misinterpreted in user space. Currently, nproc does not
> indicate the type of error at all, because a properly written user-space
> app will either not hit an error or be able to figure out what the
> problem was based on the available information. I suppose if we wanted
> to change that (which doesn't sound unreasonable), the proper way would
> be to return error flags with an error message (delivered via netlink).

This kind of error reporting is better still, as the fields then won't
be polluted with invalid data under any circumstance (assuming the code
can report subsets of the fields or some such, which I presume to be
the case given that avoiding reporting potentially computationally
expensive fields was one of the original motivators of the patch).


-- wli
