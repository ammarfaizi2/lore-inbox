Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbUDBH6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUDBH6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:58:10 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3087 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S263315AbUDBH6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:58:07 -0500
To: linux-kernel@vger.kernel.org
Cc: Jamie Lokier <jamie@shareable.org>, Paul Eggert <eggert@gnu.org>,
       Andi Kleen <ak@suse.de>, gcc@gcc.gnu.org, bug-coreutils@gnu.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20040402011411.GE28520@mail.shareable.org> (Jamie Lokier's
 message of "Fri, 2 Apr 2004 02:14:11 +0100")
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
	<20040401220957.5f4f9ad2.ak@suse.de> <7w3c7nb4jb.fsf@sic.twinsun.com>
	<20040402011411.GE28520@mail.shareable.org>
X-Hashcash: 0:040402:linux-kernel@vger.kernel.org:ab8b3e4f065b58fa
X-Hashcash: 0:040402:jamie@shareable.org:c550f695296a5468
X-Hashcash: 0:040402:eggert@gnu.org:2be7e5241be54e2e
X-Hashcash: 0:040402:ak@suse.de:e431523a0e755dd2
X-Hashcash: 0:040402:gcc@gcc.gnu.org:e4366a58331c0085
X-Hashcash: 0:040402:bug-coreutils@gnu.org:ac8642d50f28e771
Date: Fri, 02 Apr 2004 02:57:41 -0500
Message-ID: <m3isgi4xsa.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:

Jamie> When re-reading an inode, rounding the time up is done by
Jamie> setting the tv_nsec field to 999999999.

Jamie> If the on-disk timestamp is "now", i.e. the current second if
Jamie> it's a 1-second resolution, then we can avoid setting the
Jamie> timestamp to a future time by setting the tv_nsec field to the
Jamie> current wall time's nanosecond value.  There is no need to
Jamie> round the time up any more than that.

Given how much time it will take to compare the file's timestamp to
current before choosing 999999999 or now for the tv_nsec field, is
it a reasonable shortcut to just always use now's nsec value?

Obviously it is not *that* many cycles to do the compare, but we are
talking about a nanoseconds field, and the current tv_sec could
increment during the compare....

-JimC

