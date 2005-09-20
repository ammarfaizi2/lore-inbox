Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVITQze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVITQze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVITQze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:55:34 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:34489 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932711AbVITQzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:55:33 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
To: Keith Owens <kaos@ocs.com.au>, Ben Dooks <ben-linux@fluff.org>,
       linux-kernel@vger.kernel.org, patch-out@fluff.rog
Reply-To: 7eggert@gmx.de
Date: Tue, 20 Sep 2005 18:55:22 +0200
References: <4OB3R-5gu-13@gated-at.bofh.it> <4OLPC-3NQ-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EHlOt-00012f-Au@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Subject: Re: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross compile)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:

> +my $objdump;
> +if (exists($ENV{'OBJDUMP'})) {
> +     $objdump = $ENV{'OBJDUMP'};

Having a typo in the environment shouldn't silently do something different
from what's requested. Use something like

my @objdump = ( (defined $ENV{'OBJDUMP'})? $ENV{'OBJDUMP'} :
                                           "/usr/bin/objdump",
               '-s', '-j');
> +} else {
> +     $objdump = 'objdump';
> +}
> +$objdump .= ' -s -j .comment';

Having a space as the option delimiter will break if the path to objdump
contains a space. Therefore you'll need to use an array.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
