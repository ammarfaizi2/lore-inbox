Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUH1T5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUH1T5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUH1T5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:57:06 -0400
Received: from holomorphy.com ([207.189.100.168]:56744 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266488AbUH1T47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:56:59 -0400
Date: Sat, 28 Aug 2004 12:56:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040828195647.GP5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828194546.GA25523@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 09:45:46PM +0200, Roger Luethi wrote:
> Executive summary: I wrote a benchmark to compare /proc and nproc
> performance. The results are as expected: Parsing even the most simple
> strings is expensive. /proc performance does not scale if we have to
> open and close many files, which is the common case.
> In a situation with many processes p and fields/files f the delivery
> overhead is roughly O(p) for nproc and O(p*f) for /proc.
> The difference becomes even more pronounced if a /proc file request
> triggers an expensive in-kernel computation for fields that are not
> of interest but part of the file, or if human-readable files need to
> be parsed.
> Benchmark: I chose the most favorable scenario for /proc I could think
> of: Reading a single, easy to parse file per process and find every data
> item useful.  I picked /proc/pid/statm. For nproc, I chose seven fields
> that are calculated with the same resource usage as the fields in statm:
> NPROC_VMSIZE, NPROC_VMLOCK, NPROC_VMRSS, NPROC_VMDATA, NPROC_VMSTACK,
> NPROC_VMEXE, and NPROC_VMLIB.

These numbers are somewhat at variance with my experience in the area,
as I see that the internal algorithms actually dominate the runtime
of the /proc/ algorithms. Could you describe the processes used for the
benchmarks, e.g. typical /proc/$PID/status and /proc/$PID/maps for them?


-- wli
