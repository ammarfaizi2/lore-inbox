Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbTCSBfq>; Tue, 18 Mar 2003 20:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbTCSBfq>; Tue, 18 Mar 2003 20:35:46 -0500
Received: from packet.digeo.com ([12.110.80.53]:13997 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262859AbTCSBfp>;
	Tue, 18 Mar 2003 20:35:45 -0500
Date: Tue, 18 Mar 2003 19:18:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1: eth0: Transmit error, Tx status register 90
Message-Id: <20030318191833.317fa459.akpm@digeo.com>
In-Reply-To: <20030319013042.19266.qmail@linuxmail.org>
References: <20030319013042.19266.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 01:46:30.0264 (UTC) FILETIME=[5CDEE780:01C2EDB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> Hi, 
>  
> I've been benchmarking file copy operations between 2.5.65-mm1 
> and 2.4.20-2.51 since I have noticed that transferring files from my 
> 2.4.20 machine to 2.5.65-mm1 gives an steady 10MBps throughput 
> but doing the opposite (from 2.5.65-mm1 to 2.4.20) gives me a 
> mere 3MBps throughput. 

Is it slow with both scp and NFS?  Or just NFS?

If just NFS then yes, I see this too.  Transferring files 2.5->2.4 over NFS
is several times slower than 2.4->2.4 or 2.5->2.5.  Quite repeatable.

> After transferring a 256MB file using NFS and SCP, I have noticed 
> several "eth0: Transmit error, Tx status register 90.". I have attached 
> dmesg output, ioports, iomem, lsmod and lspci. 

That's a transmit underrun.  The PCI/memory system was not able to feed data
into the NIC fast enough.

Please determine when this started.  2.5.64 would be a good kernel to test
because it doesn't have the PCI changes.

