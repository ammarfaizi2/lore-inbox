Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbULPW3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbULPW3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbULPW1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:27:06 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:37004 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S262046AbULPW0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:26:32 -0500
Date: Thu, 16 Dec 2004 14:26:22 -0800 (PST)
From: Sorav Bansal <sbansal@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: bug in swapon.c (util-linux-2.12-r4)
Message-ID: <Pine.GSO.4.44.0412111733510.21024-100000@elaine17.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There is a simple bug I noticed in swapon.c (util-linux-2.12-r4):

swapon.c line 138:
  swapFiles array is indexed without checking against NULL (after call to
  realloc)

To fix this bug, you could replace lines 135-138 by the following:
	newswapFiles = realloc(..)
	if (newSwapFiles==NULL) {
	    return;
	}
	numSwaps++;
	swapFiles = newswapFiles;
	swapFiles[numSwaps-1] = strdup(line);

regards,
-Sorav

