Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUC3Gg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUC3Gg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:36:56 -0500
Received: from holomorphy.com ([207.189.100.168]:51871 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262087AbUC3Ggy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:36:54 -0500
Date: Mon, 29 Mar 2004 22:36:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-ID: <20040330063645.GH791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com> <20040329154330.445e10e2.pj@sgi.com> <20040330020637.GA791@holomorphy.com> <20040329174637.3aa16260.pj@sgi.com> <20040330025535.GD791@holomorphy.com> <20040329210917.26feb28d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329210917.26feb28d.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Whether callers experience ill effects is irrelevant.

On Mon, Mar 29, 2004 at 09:09:17PM -0800, Paul Jackson wrote:
> Not irrelevant to the callers ;)
> And Andrew might reasonably choose to prioritize fixes,
> depending in part on the impact of what they fix.
> Ah - there is one more use of *_complement, in i386/mach-es7000.
> But it masks the result in the next line with cpu_online_map, so
> also avoids propogating the damage.

This is also irrelevant. By this token, races in rarely/never-called
codepaths would not be bugs.

The cleanups are fine as cleanups. Just get arch maintainer approvals
because you _are_ relying on operational semantics specific to gcc
versions, which may not support various architectures. Do not attempt
to confuse the issue with bugfixing. Lobbying me is pointless; go to
arch maintainers.


At some point in the past, I wrote:
>> IIRC the needed changes to cpus_shift_left() are also missing from
>> your other patches in the bitmap code.

On Mon, Mar 29, 2004 at 09:09:17PM -0800, Paul Jackson wrote:
> Hmmm ... could you elaborate on this?  I don't see this bug.

I recalled a more intelligent implementation scrapped for the sake of
simplicity/merging. The version in mainline doesn't have the issue,
though it does have limitations on bitmap sizes, which I'll remove
shortly while also preserving their current satisfaction of zeroed tail
postconditions given zeroed tail preconditions. This should have no
effect and/or conflict with your changes, but rather merely restore the
arbitrary bitmap size capabilities and look vaguely more efficient.


-- wli
