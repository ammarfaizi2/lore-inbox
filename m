Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129981AbRBVVnz>; Thu, 22 Feb 2001 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRBVVnh>; Thu, 22 Feb 2001 16:43:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130910AbRBVVnP>; Thu, 22 Feb 2001 16:43:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: random PID generation
Date: 22 Feb 2001 13:42:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <974150$a9u$1@cesium.transmeta.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0EEE@ftrs1.intranet.ftr.nl> <20010222232423.A18448@home.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010222232423.A18448@home.ds9a.nl>
By author:    bert hubert <ahu@ds9a.nl>
In newsgroup: linux.dev.kernel
> 
> Well - I'm not sure that this is a good idea. When PIDs increase
> monotonically, chances are very small that the race condition implicit in
> sending any signal to a process results in killing the wrong process (ie, a
> new process, but with the same PID) - you'd need to zoom through 32000 PIDs
> in a very short time to make this happen.
> 
> With truly random PIDs, there is a much larger chance of a new process
> sitting on a recently used PID.
> 
> What would work is to have cryptographically randomly generated PIDs which
> would then guarantee not to return a previously returned number within 32000
> tries, and also not be predictable - there must be algoritms out there which
> do this.
> 

It depends on the size of your number space.  If you have a 31-bit
pid_t (since it apparently must be sign-safe) then you can take random
16-bit numbers from the /dev/urandom code and add to the last used
value instead of simple increment.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
