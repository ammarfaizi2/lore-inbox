Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRCZKCW>; Mon, 26 Mar 2001 05:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132401AbRCZKCM>; Mon, 26 Mar 2001 05:02:12 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:37786 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S132397AbRCZKCK>; Mon, 26 Mar 2001 05:02:10 -0500
Message-Id: <l03130329b6e4c32df9a7@[192.168.239.101]>
In-Reply-To: <200103260440.f2Q4eGD26052@sleipnir.valparaiso.cl>
In-Reply-To: Message from Jonathan Morton <chromi@cyberspace.org>    of
 "Sun, 25 Mar 2001 19:35:38 +0100."
 <l03130325b6e3e9bdf18e@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 26 Mar 2001 11:01:07 +0100
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm currently investigating the old non-overcommit patch, which (apart from
>> needing manual applying to recent kernels) appears to be rather broken in a
>> trivial way.  It prevents allocation if total reserved memory is greater
>> than the total unallocated memory.  Let me say that again, a different way
>> - it prevents memory usage from exceeding 50%...
>
>Think fork(2).

fork() is allowed to return a failure value, and it already does so if
there isn't enough memory (at least with the limited tests I've come up
with).  Guess again.

I have, however, found a bug in the non-overcommit patch - it seems to be
capable of double-freeing (and then some) - starting 4 Java VMs and then
closing them causes VMReserved to go negative on my system.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


