Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJRV64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJRV64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVJRV64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:58:56 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:52608 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932159AbVJRV64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:58:56 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: large files unnecessary trashing filesystem cache?
To: Badari Pulavarty <pbadari@gmail.com>, Guido Fiala <gfiala@s.netic.de>,
       lkml <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 18 Oct 2005 23:58:45 +0200
References: <4Z5WG-1iM-19@gated-at.bofh.it> <4Z6zs-27l-39@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ERzTq-0001IA-Ba@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
> On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:

[large files trash cache]

> Is there a reason why those applications couldn't use O_DIRECT ?

The cache trashing will affect all programs handling large files:

mkisofs * > iso
dd < /dev/hdx42 | gzip > imagefile
perl -pe's/filenamea/filenameb/' < iso | cdrecord - # <- never tried

Changing a few programs will only partly cover the problems.

I guess the solution would be using random cache eviction rather than
a FIFO. I never took a look the cache mechanism, so I may very well be
wrong here.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
