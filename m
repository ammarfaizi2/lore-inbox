Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGLXOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGLXOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUGLXOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:14:30 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4992 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264231AbUGLXOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:14:24 -0400
Date: Mon, 12 Jul 2004 16:14:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040712231421.GA24184@taniwha.stupidest.org>
References: <40F03665.90108@tlinx.org> <E1Bk9pA-0008HQ-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Bk9pA-0008HQ-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 01:03:04AM +0200, Bernd Eckenfels wrote:

>    open("test.txt", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3

old data blocks release (truncated), transaction for this written to
journal more-or-less synchronously

>    write(3, "test\ntest\n", 10)            = 10
>    close(3)                                = 0

new data sitting in page-cache, not written to disk (in the case of
XFS the new blocks probably aren't even allocted at this stage).  the
file size being extended is i assume recorded in the journal though.

if you crash now, you see nulls or a truncated file,  i think this is
what people are getting with dotfiles

KDE is especially good at triggering this it seems


   --cw
