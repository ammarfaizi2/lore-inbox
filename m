Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSAZJHw>; Sat, 26 Jan 2002 04:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSAZJHc>; Sat, 26 Jan 2002 04:07:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58384 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283003AbSAZJHS>; Sat, 26 Jan 2002 04:07:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Really odd behavior of overlapping named pipes?
Date: 26 Jan 2002 01:07:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2trjq$h2r$1@cesium.transmeta.com>
In-Reply-To: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there>
By author:    Rob Landley <landley@trommello.org>
In newsgroup: linux.dev.kernel
>
> You apparently can't share named pipe instances.  They short-circuit.  When I 
> open four command shells, do a mkfifo /tmp/fifo, and then do the following:
> 
> Shell one and two:
> 
> cat /tmp/mkfifo
> 
> Shell three and four:
> 
> cat > /tmp/mkfifo
> 
> Both of the write windows go into the FIRST read window.  The second read 
> window continues to block on the open, getting nothing.
> 

A pipe is *one* communications channel.

A socket is *a communications channel creator*.

It sounds like what you're expecting is what would happen if we
allowed open() on a Unix domain socket to do the obvious thing (can
we, pretty please?)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
