Return-Path: <linux-kernel-owner+w=401wt.eu-S1161285AbXAMEym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbXAMEym (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 23:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbXAMEyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 23:54:41 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:36895 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161280AbXAMEyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 23:54:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iLmypEEgEh1k/HOfC9A50hXLSlu1d7OyX5vz/qFDw2z3QRao70ijWBGc1zb4rviEcRdIrVfs38Y3tIPhKJcTNz5ZCCyilHZwxc0kgVh4FS5G05bDsjW7/xShP2fbTlZziEzEoF/4O8bS8W2+OlP8/zMZWx4Vb+NwFIbf7mBYT0M=  ;
X-YMail-OSG: VEpEB8UVM1nVLitgJ2FHsiDWWCvR7u.ky.dtrE0tq_BzH1enOifsmHx5t4F_Ymp3gjzv9aZ17.T6BhIRef9aZtnSNUPXZMoAHTSOPr4IS489Au5xcXaXlAi_1U2rEa.OGgBaiUKkWPeVeBo-
Message-ID: <45A865F7.3010900@yahoo.com.au>
Date: Sat, 13 Jan 2007 15:54:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org>
In-Reply-To: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> I'm working on an embedded PPC setup with 64M of memory and no swap.   
> I'm trying to figure out how best to tune the VM for an OOM situation  
> I'm running into.
> 
> I'm running a 2.6.16.35 kernel and have a bittorrent app that appears  
> to be initializing a large file for it to download into.  What I see  
> before running the app:
> 
> /bigfoot/usb_disk # cat /proc/meminfo
> MemTotal:        62520 kB
> MemFree:         49192 kB
> Buffers:          8240 kB
> Cached:            740 kB
> SwapCached:          0 kB
> Active:           8196 kB
> Inactive:         1236 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        62520 kB
> LowFree:         49192 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:            916 kB
> Slab:             2224 kB
> CommitLimit:     31260 kB
> Committed_AS:     1704 kB
> PageTables:         88 kB
> VmallocTotal:   933872 kB
> VmallocUsed:      9416 kB
> VmallocChunk:   923628 kB
> 
> after the OOM:
> 
> /bigfoot/usb_disk # cat /proc/meminfo
> MemTotal:        62520 kB
> MemFree:          1608 kB
> Buffers:          8212 kB
> Cached:          42780 kB
> SwapCached:          0 kB
> Active:           6228 kB
> Inactive:        45176 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:        62520 kB
> LowFree:          1608 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
> Dirty:           35208 kB
> Writeback:        5616 kB
> Mapped:            892 kB
> Slab:             7788 kB
> CommitLimit:     31260 kB
> Committed_AS:     1704 kB
> PageTables:         88 kB
> VmallocTotal:   933872 kB
> VmallocUsed:      9416 kB
> VmallocChunk:   923628 kB
> 
> Which makes me think that we aren't writing back fast enough.  If I  
> mount the drive "sync" the issue clearly goes away.
> 
> It appears from an strace we are doing ftruncate64(5, 178257920) when  
> we OOM.
> 
> Any ideas on VM parameters to tweak so we throttle this from occurring?

You don't give us the actual OOM message. In newer kernels, there has been
quite a bit of work done to improve the OOM situation -- search changelogs
in mm/oom_kill.c mm/vmscan.c mm/page_alloc.c.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
