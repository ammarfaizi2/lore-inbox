Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUHEHjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUHEHjt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHEHjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:39:49 -0400
Received: from holomorphy.com ([207.189.100.168]:50369 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267601AbUHEHiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:38:21 -0400
Date: Thu, 5 Aug 2004 00:38:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [sparc32] [12/13] gcc-3.3 macro parenthesization fix for memcpy.S
Message-ID: <20040805073813.GA14358@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jakub Jelinek <jakub@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040805044427.GV2334@holomorphy.com> <20040805044627.GW2334@holomorphy.com> <20040805044736.GX2334@holomorphy.com> <20040805044839.GY2334@holomorphy.com> <20040805044950.GZ2334@holomorphy.com> <20040805045417.GA2334@holomorphy.com> <20040805045528.GB2334@holomorphy.com> <20040805045643.GC2334@holomorphy.com> <20040805050141.GD2334@holomorphy.com> <20040805072838.GS8296@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805072838.GS8296@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 10:01:41PM -0700, William Lee Irwin III wrote:
>> From: Art Haas <ahaas@airmail.net>
>> The 1.3->1.4 changes to the arch/sparc/lib/copy_user.S file added
>> parenthesis to a number of macros within that file. The BK changlog
>> associated with this change indicate the change was to make the
>> file work with gcc-3.3.
>> When looking at the changes made, I see that similar macros exist in
>> memcpy.S as well, so would a patch adding parens to that file be
>> worthwhile? Also, just what was the problem with gcc-3.3 that was
>> resolved by adding the parenthesis? Macro mis-expansion I'm guessing.

On Thu, Aug 05, 2004 at 03:28:38AM -0400, Jakub Jelinek wrote:
> The problem was an (already fixed) gas bug, which for a short time treated
> %reg - -0x02
> as if there was a -- operator in between.
> arch/arch/lib/memcpy.S never passes -0xNN offsets to any of these macros,
> so the parenthesis is unnecessary there IMHO.

I'd be inclined to take it anyway, as macros should generally
parenthesize their arguments, though it's good to know what specific
toolchain issue the copy_user.S change was meant to deal with.

Thanks.

-- wli
