Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRCXNNY>; Sat, 24 Mar 2001 08:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCXNNO>; Sat, 24 Mar 2001 08:13:14 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:6895 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S131666AbRCXNNF>;
	Sat, 24 Mar 2001 08:13:05 -0500
Message-Id: <l03130318b6e24cc7f29a@[192.168.239.101]>
In-Reply-To: <l03130316b6e24383c538@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103240355560.1863-100000@imladris.rielhome.conectiva>
 <l03130311b6e19132f3bf@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 13:12:08 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I thought of some things which could break it, which I want to try and deal
>with before releasing a patch.  Specifically, I want to make freepages.min
>sacrosanct, so that malloc() *never* tries to use it.  This should be
>fairly easy to implement - simply subtract freepages.min from the freemem
>part.  An even nicer way would be to subtract freepages.low (or some
>similar value) instead of freepages.min for non-root or non-privileged
>processes.

Hmm, interesting.  Even with my modification - which means that
vm_enough_memory() will always return false if the allocation would clobber
freepages.min - I can still trigger OOM quite easily.  Even with no swap on
my box, there's a lot of disk activity, probably due to there being
virtually no disk cache left - could the generation of disk buffer and
cache pages be bypassing vm_enough_memory()?  If so, would using
freepages.low as the threshold rather than freepages.min help at all? (or
have I got everything muddled...)

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


