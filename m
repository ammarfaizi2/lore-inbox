Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVHAG0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVHAG0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVHAG0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:26:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:14992 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262341AbVHAG0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:26:10 -0400
Date: Mon, 1 Aug 2005 08:25:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: 7eggert@gmx.de
cc: karim@opersys.com, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Average instruction length in x86-built kernel?
In-Reply-To: <E1Dz3Pp-0000zu-6N@be1.lrz>
Message-ID: <Pine.LNX.4.61.0508010819520.6353@yvahk01.tjqt.qr>
References: <4vKU4-3sU-21@gated-at.bofh.it> <4w02Q-7e6-21@gated-at.bofh.it>
 <4w5OQ-6Z9-25@gated-at.bofh.it> <E1Dz3Pp-0000zu-6N@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Here's a script that does what I was looking for:
><snip>

Mmmmh, perlgolf?

>#!/bin/bash
>for a in "$@"
>do
>        objdump -d "$a" -j .text 
>done | perl -ne'
>BEGIN{%h=();$b=0};
>END{if($b){$h{$b}++};print map("$_: $h{$_}\n", sort(keys(%h)))};
>if(/\tnop    $/){$h{nop}++}
>elsif(/^[\s0-9a-f]{8}:\t([^\t]+) (\t?)/){
> $b+=split(" ",$1);if($2){$h{$b}++;$b=0}}'

objdump -j .text -d "$@" | perl -ne '
END{$h{$b}++if$b;print map"$_: $h{$_}\n",sort keys%h};
if(/\tnop\s*$/){$h{nop}++}    
elsif(/^.*?:\t([^\t]+) (\t?)/){
 $b+=split/ /,$1;if($2){$h{$b}++;$b=0}}'



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
