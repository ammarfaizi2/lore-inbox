Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269738AbSISPEv>; Thu, 19 Sep 2002 11:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269727AbSISPEv>; Thu, 19 Sep 2002 11:04:51 -0400
Received: from mout1.freenet.de ([194.97.50.132]:3310 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S269738AbSISPEu>;
	Thu, 19 Sep 2002 11:04:50 -0400
Date: Thu, 19 Sep 2002 17:09:59 +0200
From: axel@hh59.org
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>, riel@conectiva.com.br
Subject: Re: 2.5.36-mm1
Message-ID: <20020919150959.GA1887@prester.hh59.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, riel@conectiva.com.br
References: <3D8839B5.B37DF31C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8839B5.B37DF31C@digeo.com>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

On Wed, 18 Sep 2002, Andrew Morton wrote:

> A reminder that this changes /proc files.  Updated top(1) and
> vmstat(1) source is available at http://surriel.com/procps/

Well. I have retrieved procps from CVS and built it. But then vmstat gets an
segmentation fault. It looks like this..

prester:/root# vmstat
   procs                      memory      swap          io     system
cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id
Segmentation fault
Exit 139

And with strace it looks like this...

...
getdents64(0x5, 0x804d038, 0x400, 0)    = 0
close(5)                                = 0
open("/proc/meminfo", O_RDONLY)         = 5
lseek(5, 0, SEEK_SET)                   = 0
read(5, "MemTotal:       191112 kB\nMemFre"..., 1023) = 543
open("/proc/stat", O_RDONLY)            = 6
read(6, "cpu  35477 2 4565 80407 9871\ncpu"..., 8191) = 815
close(6)                                = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Don't know what I have done wrong. Or is the procps package for mm-series a
special one differing from the regular procps by Rik?

Best regards,
Axel
