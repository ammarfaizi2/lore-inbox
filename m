Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJNRIL>; Sun, 14 Oct 2001 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275789AbRJNRIB>; Sun, 14 Oct 2001 13:08:01 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:20231 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S275778AbRJNRHs>;
	Sun, 14 Oct 2001 13:07:48 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141707.VAA06123@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Sun, 14 Oct 2001 21:07:14 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9C38F.5CD9C5FD@welho.com> from "Mika Liljeberg" at Oct 14, 1 07:55:43 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Not very hard at all. It could be done easily with a couple of extra
> state variables.

Does current heuristics not work? :-)


> state variables. The following is a rough pseudo code (ignores
> initialization of state variables):

You missed one crucial moment: stream may consist of remnants
for long time or even forever. It is normal case. And rcv_mss is used
not only and mostly not for ACKing, it is used in really important places
(SWS avoidance et al), where specs propose to use your advertised MSS,
which does not work at all when you talk over high MTU interfaces.

The approach (invented by Andi?) provided necessary robustness,
checking for two segments in row and suppressing MSS drops below 536.
Check for PSHless segments allows to detect really low mtu reliably.

Alexey
