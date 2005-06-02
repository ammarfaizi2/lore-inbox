Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFBJ0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFBJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFBJ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 05:26:19 -0400
Received: from mgw-ext04.nokia.com ([131.228.20.96]:5827 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP id S261300AbVFBJ0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 05:26:16 -0400
Date: Thu, 2 Jun 2005 12:17:59 +0300
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
To: "Artem B. Bityuckiy" <dedekind@yandex.ru>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Writing large files onto sync mounted MMC corrupts the FS
Message-ID: <20050602091759.GA9161@angel.research.nokia.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
References: <20050601091320.GA1472@angel.research.nokia.com> <20050601131006.GL23621@csclub.uwaterloo.ca> <429EACC9.30303@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429EACC9.30303@yandex.ru>
X-Operating-System: GNU/Linux angel.research.nokia.com
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 02 Jun 2005 09:17:47.0393 (UTC) FILETIME=[F10B6710:01C56753]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 10:52:57AM +0400, ext Artem B. Bityuckiy wrote:
> So, we should first ask whether this happens with *new* MMC cards or
not.

Flash manufactorers typically claim 100k erase cycles -- some even 1M.
If FAT is updated after each written 512 byte block, filling 64MiB
card in synchronous mode would cause over 100k FAT updates.  One
couldn't even fill a new 64MiB card without already breaking it.

With asynchronous mount, one could limit the dirty_ratio from proc to
reduce the sync time against sudden power loss. But wouldn't this have
the same adverse wearing effect as with synchronous mode once the
dirty_ratio is hit and writing still proceeds?

Jarkko Lavinen
