Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbRCXUF7>; Sat, 24 Mar 2001 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRCXUFs>; Sat, 24 Mar 2001 15:05:48 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:46323 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131778AbRCXUFd>; Sat, 24 Mar 2001 15:05:33 -0500
Message-Id: <l03130319b6e29896c21e@[192.168.239.101]>
In-Reply-To: <3ABCE547.DD5E78B9@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 20:04:38 +0000
To: Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>While my post didn't give an exact formula, I was quite clear on the fact that
>the system is allowing the caches to overrun memory and cause oom problems.
>I'm more than happy to test patches, and I would even be willing to suggest
>some algorithms that might help, but I don't know where to stick them in the
>code.  Most of the people who have been griping are in a similar position.

Meanwhile, I'm looking *very* hard at the VM system and trying to figure
out how it works.  So far I've got an "improved" system under test which
requires a little stress to cause an OOM-before-malloc-failure.  Right now
I'm working on making the OOM happen only when it *really* needs to -
previously, as some pointed out, it could trigger far too early, for
example when there was lots of buffer and cache memory that could
potentially be cannibalised.

Right now my best approximation is to make the OOM test be as optimistic as
it is safe to be, and the vm_enough_memory() test as pessimistic as
sensible.  Expect a test patch to appear on this list soon.

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


