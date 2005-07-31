Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVGaCU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVGaCU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGaCU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:20:28 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:33729 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261537AbVGaCT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:19:27 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: Average instruction length in x86-built kernel?
To: karim@opersys.com, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Sun, 31 Jul 2005 04:19:00 +0200
References: <4vKU4-3sU-21@gated-at.bofh.it> <4w02Q-7e6-21@gated-at.bofh.it> <4w5OQ-6Z9-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1Dz3Pp-0000zu-6N@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour <karim@opersys.com> wrote:

> Here's a script that does what I was looking for:
<snip>

#!/bin/bash
for a in "$@"
do
        objdump -d "$a" -j .text 
done | perl -ne'
BEGIN{%h=();$b=0};
END{if($b){$h{$b}++};print map("$_: $h{$_}\n", sort(keys(%h)))};
if(/\tnop    $/){$h{nop}++}
elsif(/^[\s0-9a-f]{8}:\t([^\t]+) (\t?)/){
 $b+=split(" ",$1);if($2){$h{$b}++;$b=0}}'

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
