Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbTEHJtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 05:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbTEHJtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 05:49:05 -0400
Received: from holomorphy.com ([66.224.33.161]:61334 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261254AbTEHJtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 05:49:04 -0400
Date: Thu, 8 May 2003 03:01:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nir Livni <nirl@cyber-ark.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shared objects, ELFs and memory usage
Message-ID: <20030508100128.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nir Livni <nirl@cyber-ark.com>, linux-kernel@vger.kernel.org
References: <E1298E981AEAD311A98D0000E89F45134B55FB@ORCA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1298E981AEAD311A98D0000E89F45134B55FB@ORCA>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 12:54:23PM +0300, Nir Livni wrote:
> After compiling and linking my .so with the -shared option,
> I've inspected strace output.
> I can clearly see that the shared object (which is 2MB size) is NOT being
> shared:
> 1395  open("/usr/local/sharedclient.so", O_RDONLY) = 6
> 1395  read(6, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\200"...,
> 1024) = 1024
> 1395  fstat64(6, {st_mode=S_IFREG|0644, st_size=2079700, ...}) = 0
> 1395  old_mmap(NULL, 2118824, PROT_READ|PROT_EXEC, MAP_PRIVATE, 6, 0) =
> 0x401ea000
> Any idea why ?
> (Please CC me because I am not subscribed)

It's called copy-on-write sharing. It is shared with the proviso that
all modified pages are privatized and not committed to disk.


-- wli
