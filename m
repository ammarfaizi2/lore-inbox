Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSANXNY>; Mon, 14 Jan 2002 18:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSANXNO>; Mon, 14 Jan 2002 18:13:14 -0500
Received: from quark.didntduck.org ([216.43.55.190]:39178 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289270AbSANXNE>; Mon, 14 Jan 2002 18:13:04 -0500
Message-ID: <3C4365EB.5AA2DEA3@didntduck.org>
Date: Mon, 14 Jan 2002 18:12:43 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <Pine.LNX.4.40.0201141409580.22904-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> the impact is in all calls to the module, if they are far calls instead of
> near calls each and every call is (a hair) slower.
> 
> so the code can be the same and still be slower to get to.
> 
> you can argue that it's not enough slower to matter, but even Alan admits
> there is some impact.
> 
> David Lang

Let's get the terminology right here (for x86 at least):
Far jump: Changes to a new code segment, absolute address
Near jump: Same code segment, 4-byte relative offset
Short jump: Same code segment, 1-byte signed offset

The kernel never uses far jumps except for some BIOS calls and during
booting.  The difference betwen near and short jumps is very minute. 
Short jumps are limited to +/- 128 bytes, so are really only applicable
for small loops.  All function calls between object files must be near
jumps, as the assembler does not not know the distance of an unresolved
symbol and must assume the largest possible offset.

--

				Brian Gerst
