Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281188AbRKTRwB>; Tue, 20 Nov 2001 12:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKTRvs>; Tue, 20 Nov 2001 12:51:48 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:1808 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S281184AbRKTRvd>; Tue, 20 Nov 2001 12:51:33 -0500
Date: Tue, 20 Nov 2001 20:51:05 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: [alpha] cleanup opDEC workaround
Message-ID: <20011120205105.A15395@jurassic.park.msu.ru>
In-Reply-To: <20011119232355.C16091@redhat.com> <20011120133150.A9033@jurassic.park.msu.ru> <20011120090818.A16366@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120090818.A16366@redhat.com>; from rth@redhat.com on Tue, Nov 20, 2001 at 09:08:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 09:08:18AM -0800, Richard Henderson wrote:
> Oh, it depended on this one.

Ok, but with opDEC_fix = 8 we actually skip to addt/stt, so that asm
probably should be rearranged to

		"fmov $f31, $f0\n\t"
		"cvttq/svm $f31, $f31\n\t"
		"addt $f31, $f31, $f31\n\t"
		"cmpteq $f31, $f31, $f0\n\t"
		"stt $f0, %0"

Further, if fp emulation isn't compiled in, we'll have kernel mode
instruction fault. A quick fix appears to be

			regs.pc += opDEC_fix;
+			if (opDEC_fix == 8)
+				return;

Did I missed something?

Ivan.
