Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbSLELbZ>; Thu, 5 Dec 2002 06:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267296AbSLELbZ>; Thu, 5 Dec 2002 06:31:25 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31493 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267292AbSLELbY>; Thu, 5 Dec 2002 06:31:24 -0500
Date: Thu, 5 Dec 2002 12:38:48 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Alexander.Riesen@synopsys.com, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021205113848.GC15405@merlin.emma.line.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Alexander.Riesen@synopsys.com, linux-kernel@vger.kernel.org
References: <Alexander.Riesen@synopsys.com> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <200212050042.gB50ga4C001486@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212050042.gB50ga4C001486@eeyore.valparaiso.cl>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2002, Horst von Brand wrote:

> Alex Riesen <Alexander.Riesen@synopsys.com> said:
> 
> [...]
> 
> > looks correct. The interpreter (/bin/sh) has got everything after
> > its name. IOW: "-- # -*- perl -*- -T"
> > It's just solaris' shell (/bin/sh) just ignores options starting with
> > "--". And freebsd's as well.
> 
> And Linux's too. Try it.

Is there the "Linux's /bin/sh"? I believe most distributions use GNU
bash for /bin/sh, and that certainly does NOT ignore these, but parse.

The problem is that binfmt_script.c does not split the remainder of the
line at whitespace.

Assuming your current working directory does not have files that match
-*-:

$ /bin/sh '-- # -*- perl -*- -T'
/bin/sh: -- # -*- perl -*- -T: invalid option
Usage:  /bin/sh [GNU long option] [option] ...
        /bin/sh [GNU long option] [option] script-file ...
GNU long options:
        --debug
...

$ /bin/bash -- # -*- perl -*- -T
$ 

$ /usr/bin/ksh '-- # -*- perl -*- -T'
/usr/bin/ksh: /usr/bin/ksh: --: unknown option

$ /usr/bin/ksh -- # -*- perl -*- -T
$

$ /usr/bin/zsh '-- # -*- perl -*- -T'
/usr/bin/zsh: no such option:  # _*_ perl _*_ _T

$ /usr/bin/zsh -- # -*- perl -*- -T
$

-- 
Matthias Andree
