Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVAEUmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVAEUmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVAEUl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:41:59 -0500
Received: from holomorphy.com ([207.189.100.168]:45721 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262653AbVAEUhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:37:47 -0500
Date: Wed, 5 Jan 2005 12:37:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: pmeda@akamai.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch  /proc] Speedup /proc/pid/maps
Message-ID: <20050105203740.GF7961@holomorphy.com>
References: <200501052055.MAA10940@allur.sanmateo.akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501052055.MAA10940@allur.sanmateo.akamai.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 12:55:37PM -0800, pmeda@akamai.com wrote:
> This patch uses find_vma() to improve the read response of /proc/pid/maps.
> It attempts to make the liner scan instead of quadratic walk and utilise
> rb tree.  Reading the file was doing sequential scan from the begining to
> file position all the time, and taking a quite long time.
> The improvements came from f_version/m_version and resulting in
> mmap_cache match. Even if mmap_cache does not match, rb tree walk
> should be faster than sequential walk. First attempt was to put the
> state across read system calls into private data. Later got
> inspiration from wli's pid patch using f_version in readdir of /proc.
> Other advantage is, f_version will be cleared automatically by lseek.
> The test program creates 32K maps and splits them into two(limited by
> max_map_count sysctl) using mprotect(0). After the patch, the read
> time improves from many seconds to milliseconds, and does not grow
> superlinearly with number of read calls.
> Help taken from Peter Swain in idea and testing.

This is an excellent improvement which makes kernel instrumentation
interfere less with the instrumented workload. I wholly endorse it.


-- wli
