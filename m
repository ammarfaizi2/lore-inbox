Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271822AbRHUSta>; Tue, 21 Aug 2001 14:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271819AbRHUStL>; Tue, 21 Aug 2001 14:49:11 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:7913 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271815AbRHUStE>;
	Tue, 21 Aug 2001 14:49:04 -0400
Date: Tue, 21 Aug 2001 19:49:12 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <2352526043.998423352@[10.132.112.53]>
In-Reply-To: <9lu91c$n5v$3@abraham.cs.berkeley.edu>
In-Reply-To: <9lu91c$n5v$3@abraham.cs.berkeley.edu>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, let's not.  If the attacker has a SHA-1 exploit, then all your
> SSL and IPSEC and other implementations are insecure, and they are
> probably the only reason you're using /dev/random anyway.

Fair point, though for some applications one could conceivably be
using a different hash, and there are applications where breaking
the hash gives you less than breaking the encryption.

> Instead, let's assume SHA-1 is good, since it probably is, and since
> you have to assume this anyway for the rest of your system.

But if we assume SHA-1 is good, then you might as well drop all the
entropy measurement and blocking logic, and /dev/urandom is
fine for /ANY/ application. Furthermore, if SHA-1 is good,
Robert's patch does no harm, but makes existing applications
work.

IE if we assume SHA-1 is unbreakable, Robert's patch is harmless.
If we assume SHA-1 /is/ breakable, Robert's patch is harmless
if, and only if, in situations where it is configured on,
it doesn't overestimate the entropy network events provide
(sometimes this may be 0, in which case don't switch it on).

--
Alex Bligh
