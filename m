Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVF3Tj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVF3Tj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVF3Tjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:39:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18430 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263015AbVF3TjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:39:11 -0400
Date: Thu, 30 Jun 2005 14:44:58 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>,
       emily@serge.austin.ibm.com
Subject: [patch 0/12] lsm stacking v0.2: intro
Message-ID: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The set of patches to follow introduces support for stacking LSMs.
This is its second posting to lkml.  I am sending it out in the hopes of
soliciting feedback and testing, with the obvious eventual goal of
mainline adoption.

The patches mainly do the following:

   1. Introduce the stacker LSM.
   2. Change the kernel object void * security fields to be hlists,
      and introduce an api for modules to share these.
   3. Modify SELinux to make use of stacker.
   4. Modify seclvl to use stacker.

Motivation:

The purpose of these patches is to enable stacking multiple security
modules.  There are several cases where this would be very useful.  It
eases the testing of new modules with distro kernels, as it makes it
possible to stack new modules with selinux and capabilities -- for
instance if a user is running fedora.  Second, it enables running
selinux (or LIDS, etc) with integrity verification modules.  (Digsig is
an example of these, and within a few months hopefully the TPM-enabled
slim+evm modules, which verifies integrity of file contents and extended
attributes such as selinux contexts
(http://www.acsac.org/2004/workshop/David-Safford.pdf) will be released
for mainline inclusion).  Thirdly, there are systems where running
selinux is not practical for footprint reasons, and the security goals
are easily expressed as a very small module.  For instance, it might
be desirable to confine a web browser on a zaurus, or to implement a
site security policy on old hardware as per
http://mail.wirex.com/pipermail/linux-security-module/2005-May/6071.html

Performance impact of the actual stacker module is negligable.  The
security_{get,set,del,add}_value API does have a small performance
impact.  Please see
http://marc.theaimsgroup.com/?l=linux-security-module&m=111820455332752&w=2
and
http://marc.theaimsgroup.com/?l=linux-security-module&m=111824326500837&w=2
if interested in the performance results.  I am certainly interested in
ways to further speed up security_get_value.

thanks,
-serge
