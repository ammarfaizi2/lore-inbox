Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCOWsQ>; Sat, 15 Mar 2003 17:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCOWsQ>; Sat, 15 Mar 2003 17:48:16 -0500
Received: from holomorphy.com ([66.224.33.161]:44755 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261608AbTCOWsP>;
	Sat, 15 Mar 2003 17:48:15 -0500
Date: Sat, 15 Mar 2003 14:58:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030315225842.GA20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, bzzz@tmi.comex.ru,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m365qk1gzx.fsf@lexa.home.net> <20030315220241.GX20188@holomorphy.com> <20030315143718.60e006b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315143718.60e006b7.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> 32x/48GB NUMA-Q
>> Throughput 257.986 MB/sec 128 procs
>> dbench 128  95.36s user 4833.06s system 2832% cpu 2:53.97 total
>> vma      samples  %-age       symbol name
>> c01dc9ac 4532033  21.4566     .text.lock.dec_and_lock
>> c0169c0b 3835802  18.1603     .text.lock.dcache
>> c0106ff4 1741849  8.24666     default_idle

On Sat, Mar 15, 2003 at 02:37:18PM -0800, Andrew Morton wrote:
> Looks like it's gone nuts when 128 processes all try to close lots of
> files at the same time.
> One possible reason for this leaping out is that all the instances are now
> achieving more uniform runtimes.   You can tell that by comparing the dbench
> dots.

For some reason this version of dbench doesn't produce dots. I logged
what it did produce, though. It looks something like this:

8  103.63 MB/sec^M 128      4008  105.52 MB/sec^M 128      4397  108.04 MB/sec^M 128  
    4811  109.90 MB/sec^M 128      5243  111.89 MB/sec^M 128      5637  114.19 MB/sec
 128      6039  117.42 MB/sec^M 128      6421  120.99 MB/sec^M 128      6779  124.12 M
B/sec^M 128      7120  127.06 MB/sec^M 128      7467  128.75 MB/sec^M 128      7799  1
30.19 MB/sec^M 128      8146  131.55 MB/sec^M 128      8551  132.97 MB/sec^M 128      
8975  134.09 MB/sec^M 128      9374  135.67 MB/sec^M 128      9737  137.73 MB/sec^M 12
8     10123  140.34 MB/sec^M 128     10503  142.81 MB/sec^M 128     10847  145.13 MB/s
ec^M 128     11161  146.17 MB/sec^M 128     11511  147.09 MB/sec^M 128     11857  147.
92 MB/sec^M 128     12293  149.22 MB/sec^M 128     12711  149.91 MB/sec^M 128     1309
6  151.01 MB/sec^M 128     13470  152.52 MB/sec^M 128     13808  154.25 MB/sec^M 128  
   14176  156.10 MB/sec^M 128     14517  157.65 MB/sec^M 128     14842  158.75 MB/sec
 128     15200  159.51 MB/sec^M 128     15558  159.99 MB/sec^M 128     15947  160.84 M
B/sec^M 128     16372  161.64 MB/sec^M 128     16805  162.56 MB/sec^M 128     17175  1
63.49 MB/sec^M 128     17523  164.99 MB/sec^M 128     17884  166.28 MB/sec^M 128     1
8237  167.82 MB/sec^M 128     18575  168.78 MB/sec^M 128     18919  169.10 MB/sec^M 12
8     19246  169.26 MB/sec^M 128     19600  169.73 MB/sec^M 128     19983  170.34 MB/s
ec^M 128     20398  170.91 MB/sec^M 128     20782  171.59 MB/sec^M 128     21126  172.
44 MB/sec^M 128     21456  173.34 MB/sec^M 128     21792  174.53 MB/sec^M 128     2213
8  175.44 MB/sec^M 128     22499  176.01 MB/sec^M 128     22821  176.11 MB/sec^M 128  


... and dos2unix just annihilated the log from the last run ...


-- wli
