Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132852AbRDEMDe>; Thu, 5 Apr 2001 08:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132863AbRDEMDY>; Thu, 5 Apr 2001 08:03:24 -0400
Received: from mail.zmailer.org ([194.252.70.162]:31748 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132852AbRDEMDI>;
	Thu, 5 Apr 2001 08:03:08 -0400
Date: Thu, 5 Apr 2001 15:02:19 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Bart Trojanowski <bart@jukie.net>
Cc: Manoj Sontakke <manojs@sasken.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: which gcc version?
Message-ID: <20010405150219.B873@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0104051930580.2687-100000@pcc65.sasi.com> <Pine.LNX.4.30.0104050732080.13246-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.30.0104050732080.13246-100000@localhost>; from bart@jukie.net on Thu, Apr 05, 2001 at 07:37:03AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2001 at 07:37:03AM -0400, Bart Trojanowski wrote:
> On Thu, 5 Apr 2001, Manoj Sontakke wrote:
> gcc requires a function call to do a mul/div on a long long.  There is no
> easy way to do a 64bit op of this type on a 32 bit CPU...

	Actually there is -- presuming your CPU has lots of registers,
	which i386 does not have...

	This rule -- "no -lgcc in kernel code" -- is to trap code which
	in fast-paths would call those slow routines.
	Fastpaths should either not grok such values, or at most use
	shifts.

	To think of it, there really should be explicitely callable
	versions of these with LinuxKernel names for them, not gcc
	builtins.   That way people would *know* they are doing
	something, which is potentially very slow.
	(And the API would not change from underneath them.)

> Cheers,
> Bart.
> -- 
> 	WebSig: http://www.jukie.net/~bart/sig/

/Matti Aarnio
