Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTKISoe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 13:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTKISoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 13:44:34 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:20623 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262449AbTKISoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 13:44:32 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Some thoughts about stable kernel development
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 09 Nov 2003 19:41:02 +0100
Message-ID: <m3u15de669.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is no doubt any development model has some problems, and ours
can't be an exception. I'd like to share with you an idea which
recently found a way to my mind.

There is a problem that a development cycle (time between stable
= non-pre/rc versions) is long. Imagine a situation when we are at
some pre-3 stage, the kernel tree is full of problems which must be
resolved before the final release, and some serious security-class
bug has been found. We would be unable to have a secured stable
version shortly unless the maintainer checks through all changes to
last stable kernel, identify fixes which are both safe and necessary
(hopefully there are no necessary unsafe ones at that time), and
back-out everything else. Such a scenario is real and that way we might
end up with official kernel being unusable for any Internet-connected
tasks for weeks.

Here is what I propose:
As all of you know, the development cycle can be shortened by using
two separate trees for a stable kernel line.

Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
both kernels, and other patches (which can't go to "rc" kernel) would
be applied to 2.4.24-pre1 only.

After 2.4.23-rcX becomes final 2.4.23, the 2.4.24-preX would become
2.4.24-rc1 and would be a base for 2.4.25-pre1.

This way:
- there would be no time when patches aren't accepted
- the development cycle would be shorter. In fact it would be much
  less important as there would always be an up-to-date stable version.
- we would avoid a mess of having two separate trees, with different
  fixes going in and out.
- the amount of added maintainer's work is minimal, especially if patch
  authors specify which tree they want it to go in (i.e. even a small
  trivial patch would be applied to "pre" only if requested by the
  author).
- the 2.X.Y-pre* patch would always be based on latest 2.X.Y-1-rc or
  final kernel.
- as an option, we could go from absolute to incremental -pre and -rc
  patches: i.e. rc2 would be based on rc1 and pre2 on pre1. It would be
  easier for both disks and people (no need to patch -R).

Of course, I know 2.4-ac patches maintained by Alan Cox fulfilled
some (most?) of these points, even if it wasn't their primary function.

This mail isn't about criticizing anyone nor anything, and is not only
related to 2.4 kernel - I just try to make the development process of
stable kernel lines a little better.

Comments?
-- 
Krzysztof Halasa, B*FH
