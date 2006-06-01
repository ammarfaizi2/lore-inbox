Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWFARZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWFARZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWFARZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:25:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52613 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965129AbWFARZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:25:25 -0400
Date: Thu, 1 Jun 2006 10:29:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: mbligh@mbligh.org, mbligh@google.com, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060601102929.1f62d624.akpm@osdl.org>
In-Reply-To: <447F1702.3090405@shadowen.org>
References: <447DEF49.9070401@google.com>
	<20060531140652.054e2e45.akpm@osdl.org>
	<447E093B.7020107@mbligh.org>
	<20060531144310.7aa0e0ff.akpm@osdl.org>
	<447E104B.6040007@mbligh.org>
	<447F1702.3090405@shadowen.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 17:34:10 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> Last time I tried to split search -mm1 and she was being a hideous pig,
> I just couldn't get any bit of it to compile without the rest.

You shouldn't bisect blindly.

Looking at the series file
(ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/patch-series):

...
add-scsi_add_host-failure-handling-for-nsp32.patch
qla1280-fix-section-mismatch-warnings.patch
bogus-disk-geometry-on-large-disks.patch
bogus-disk-geometry-on-large-disks-warning-fix.patch
megaraid_sas-switch-fw_outstanding-to-an-atomic_t.patch
megaraid_sas-add-support-for-zcr-controller.patch
megaraid_sas-add-support-for-zcr-controller-fix.patch
...

megaraid_sas-add-support-for-zcr-controller-fix.patch is a fix against
megaraid_sas-add-support-for-zcr-controller.patch, so if the bisection
lands you on megaraid_sas-add-support-for-zcr-controller.patch then
obviously one should apply
megaraid_sas-add-support-for-zcr-controller-fix.patch by hand as well.

You'll often find great streams of similarly-named contiguous patches - you
should apply either all of them or none of them.  Otherwise you're testing
a known-to-be-broken kernel which has an already-available fix ;)

http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
describes the bisection technique I use.

If you're using git-bisect, well, try to have a nice day anyway.

>  Will try and track this down with the new -mm.

Would be great, thanks.
