Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264716AbUD1Jva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264716AbUD1Jva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264715AbUD1Jva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:51:30 -0400
Received: from mail.jambit.com ([62.245.207.83]:40715 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S264713AbUD1Jv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:51:28 -0400
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	linux-kernel@vger.kernel.org<linux-kernel@vger.kernel.org>
						    ^-missing end of address
Date: Wed, 28 Apr 2004 11:51:14 +0200
MIME-Version: 1.0
Subject: MS_INVALIDATE broken, what alternative?
Cc: Jamie Lokier <jamie@shareable.org>
Message-ID: <408F9AB2.26880.AE166D@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The msync() MS_INVALIDATE operation should produce behavior something like 
the following:

Invalidate cached copies of mapped data: the mapped region is synchronized 
with the contents of the file.  All pages of the mapped region that are 
inconsistent with the underlying file data are marked as invalid, and when 
next referenced, the contents of the page will be copied from the 
corresponding location in the file.  As a result, any changes that have 
been made directly to the file by another process using write() are made 
visible in the mapped region.

(To be precise, SUSv3 says:

    When MS_INVALIDATE is specified, msync( ) shall invalidate 
    all cached copies of mapped data that are inconsistent with 
    the permanent storage locations such that subsequent 
    references shall obtain data that was consistent with the 
    permanent storage locations sometime between the call to 
    msync( ) and the first subsequent memory reference to the data.
)

However as noted in a recent thread 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=108083668427418&w=2), 
the current Linux implementation of this flag is broken: it provides 
behavior equivalent to flags==0.

Is there any way of achieving this functionality with current kernels?  
(Or might MS_INVALIDATE actually get correctly implemented?)

Thanks,

Michael
--
Michael Kerrisk
michael.kerrisk@gmx.net





