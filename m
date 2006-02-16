Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWBPKm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWBPKm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 05:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWBPKm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 05:42:29 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:56660 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751306AbWBPKm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 05:42:28 -0500
Message-ID: <43F45713.4010803@tls.msk.ru>
Date: Thu, 16 Feb 2006 13:42:27 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Knutar <jk-lkml@sci.fi>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: readahead logic and I/O errors
References: <43F39089.2050302@tls.msk.ru> <200602160853.16297.jk-lkml@sci.fi>
In-Reply-To: <200602160853.16297.jk-lkml@sci.fi>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Knutar wrote:
> On Wednesday 15 February 2006 22:35, Michael Tokarev wrote:
> 
> 
>>after FIRST I/O error, linux continued trying reading-ahead,
>>discovering more and more failed blocks, as dmesg said.
> 
> Sorry for hijacking the thread, but on another note, is there
> anyway to tell linux to tell the drive to not bother retrying
> read errors? Would be perfect for streaming video from a
> CD or DVD. Usually video players have excellent error
> recovery themselves, which probably looks better on the
> screen than the movie coming to a grinding halt due to
> the retries.

It looks like exactly the same issue.  When you set readahead
for the drive to 0 (to disable it), the only retry which is
done is the one by drive itself.  Linux return I/O error
to the application right when drive tells so, and it's up
to the application to descide what to do next - abort
(like `cp' does), or continue next (or next-to-next)
sector etc.  I don't know how to control retries in
the drive (if it's at all possible).

/mjt
