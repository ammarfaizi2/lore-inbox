Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUBKQgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUBKQgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:36:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20614 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265853AbUBKQgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:36:10 -0500
Subject: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Tim Connors <tconnors+linuxkernel1076481367@astro.swin.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>
In-Reply-To: <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au>
References: <20040209115852.GB877@schottelius.org>
	 <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au>
Content-Type: text/plain
Message-Id: <1076517309.21961.169.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 10:35:10 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 00:39, Tim Connors wrote:
> I submitted a bug to the jfs people, because jfs incorrectly returns
> -EINVAL (this isn't even documented in man pages as a valid return
> from open()) from an open() on a filename with UTF-8 in it.
> 
> See http://www-124.ibm.com/developerworks/bugs/?func=detailbug&bug_id=3838&group_id=35
> and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=229308
> 
> This was triggered just by upgrading the console-utils package in
> debian (the problem existed all along, except that when I first made
> the filesystem a jfs one, I reinstalled from backups, rather than
> reinstalling debian from scratch)

Yeah, JFS has poor default behavior based on CONFIG_NLS_DEFAULT.  I
attempted to explain why it works that way in the first bug listed above
if anyone is curious.

I think the right thing for JFS to do is to change the default behavior
to simply store the bytes as they are seen, and to only do charset
conversion when the iocharset mount option is explicitly set.  This may
impact some current users, but they will be able to get the old behavior
by setting iocharset to whatever CONFIG_NLS_DEFAULT is set to in the
running kernel.

I intend to make this change soon if there are no objections.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

