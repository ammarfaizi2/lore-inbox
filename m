Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTFRGj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 02:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTFRGj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 02:39:26 -0400
Received: from dp.samba.org ([66.70.73.150]:15294 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264547AbTFRGj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 02:39:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.2991.972670.344808@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2003 16:50:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: copy_from_user
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago (in the 2.1 series IIRC) we added code to copy_from_user
to zero the remainder of the destination buffer if we faulted on the
source.  The motive was to eliminate some potential security holes
that could arise if callers didn't check the return value from
copy_from_user and continued on to pass the contents of the
destination buffer back to userspace in one way or another.

However, I notice that copy_from_user on i386 in 2.5 doesn't clear the
destination if the access_ok() check fails, or if the size is 1, 2 or
4.  Have all the callers of copy_from_user been checked?  Is the
zeroing of the destination no longer necessary?

Thanks,
Paul.
