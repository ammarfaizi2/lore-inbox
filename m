Return-Path: <linux-kernel-owner+w=401wt.eu-S965095AbXAKEwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXAKEwj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 23:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbXAKEwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 23:52:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55609 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbXAKEwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 23:52:38 -0500
Date: Wed, 10 Jan 2007 20:51:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Aubrey <aubreylee@gmail.com>
Cc: "Hua Zhong" <hzhong@gmail.com>, "Hugh Dickins" <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, torvalds@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-Id: <20070110205157.4aca3689.akpm@osdl.org>
In-Reply-To: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 10:57:06 +0800
Aubrey <aubreylee@gmail.com> wrote:

> Hi all,
> 
> Opening file with O_DIRECT flag can do the un-buffered read/write access.
> So if I need un-buffered access, I have to change all of my
> applications to add this flag. What's more, Some scripts like "cp
> oldfile newfile" still use pagecache and buffer.
> Now, my question is, is there a existing way to mount a filesystem
> with O_DIRECT flag? so that I don't need to change anything in my
> system. If there is no option so far, What is the right way to achieve
> my purpose?

Not possible, basically.

O_DIRECT reads and writes must be aligned to the device's block size
(usually 512 bytes) in memory addresses, file offsets and read/write request
sizes.  Very few applications will bother to do that and will hence fail if
their files are automagically opened with O_DIRECT.

