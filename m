Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTLVI63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbTLVI63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 03:58:29 -0500
Received: from holomorphy.com ([199.26.172.102]:8864 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263984AbTLVI61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 03:58:27 -0500
Date: Mon, 22 Dec 2003 00:57:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ioe-lkml@rameria.de
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-ID: <20031222085752.GB27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, ioe-lkml@rameria.de
References: <20031221180044.0f27eca1.pj@sgi.com> <20031221224745.268db46d.akpm@osdl.org> <20031221231918.34fcca86.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221231918.34fcca86.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, akpm wrote:
>> Please, hang onto it until we get things synced up a bit more.

On Sun, Dec 21, 2003 at 11:19:18PM -0800, Paul Jackson wrote:
> Ok - good idea.  I'll resend later on.  There is no hurry on this one.

A rereading of this thread reveals the point of the thing was missed.
It's supposed to iterate over online cpus in an given bitmap. It was
meant to replace iterations like:

for_each_cpu(cpu, mask) {
	if (!cpu_online(cpu))
		continue;
	do_something(cpu);
}

with

for_each_online_cpu(cpu, mask)
	do_something(cpu);

Using any_online_cpu() as the starting point repairs it, since that
properly ands mask with cpu_online_map and hands back the first cpu,
though it's only a coincidence it hands back the first such cpu. There
isn't a a first_online_cpu() in the API, that's just effectively what
any_online_cpu() does at the moment.

On the other hand, I just don't care anymore, apart from clarifying
intent so as to counter the implication that all I did back then was
crap gibberish all over the tree. I personally have received zero
recognition or other return on my efforts in this area apart from the
mere fact it was merged. In fact, rather the opposite.


-- wli
