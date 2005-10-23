Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVJWKls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVJWKls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVJWKls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:41:48 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:39362 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751444AbVJWKlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:41:47 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Understanding Linux addr space, malloc, and heap
To: Kyle Moffett <mrmacman_g4@mac.com>, "Vincent W. Freeh" <vin@csc.ncsu.edu>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 23 Oct 2005 12:41:35 +0200
References: <505ru-8qi-1@gated-at.bofh.it> <505Lp-B4-81@gated-at.bofh.it> <506QZ-2cH-3@gated-at.bofh.it> <5070Y-2qP-23@gated-at.bofh.it> <507ac-2Cm-25@gated-at.bofh.it> <507NL-3Em-29@gated-at.bofh.it> <507Xd-3QT-19@gated-at.bofh.it> <50xnU-7s2-37@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ETdIF-0000h8-Iw@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Oct 21, 2005, at 12:24:50, Vincent W. Freeh wrote:

>> I guess I live in a different world.  I do lots of things I'm not
>> "supposed" to do.
> 
> So why are you complaining that it doesn't work?  "Doctor, it hurts
> when I use my toes to hold a nail as I hammer it in!" "Well don't do
> that then!"

I'm not supposed to run linux on i386, ask Bill. Why do I do it then?

>> Moreover, it is very sensible and usable to mprotect malloc pages.
> 
> DANGER! DANGER WILL ROBINSON! DANGER!  malloc() is *NOT* guaranteed
> or even theoretically implemented to return pages.

If you allocate a block of 2*PAGESIZE-1 bytes, *any* allocation method is
*guaranteed* return at least one complete page. (BTW: The example from the
manpage is wrong since it does only make sure the starting address is on
the page, but not that the end of the protected memory is within the
allocated area. Whom should I contact?)

But even if Vincend makes the next malloc/free/whatever to be fubar,
or if he made the world explode, mprotect is still required to report
an error if the requested action failed. If it doesn't do that for
mprotecting _any_ range, no matter how strange it may be, it is broken.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
