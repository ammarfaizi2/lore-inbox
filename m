Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269511AbUJSQUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269511AbUJSQUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJSQTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:19:50 -0400
Received: from galaxy.systems.pipex.net ([62.241.162.31]:29876 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269527AbUJSQRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:17:35 -0400
Message-ID: <41753E1D.8010608@dsl.pipex.com>
Date: Tue, 19 Oct 2004 17:17:33 +0100
From: Johan Groth <jgroth@dsl.pipex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ross Biro <ross.biro@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Dma problems with Promise IDE controller
References: <41741CDB.5010300@dsl.pipex.com>	 <58cb370e04101813221d36b793@mail.gmail.com> <8783be660410181420683d1341@mail.gmail.com>
In-Reply-To: <8783be660410181420683d1341@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
> On Mon, 18 Oct 2004 22:22:38 +0200, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> 
>>On Mon, 18 Oct 2004 20:43:23 +0100, Johan Groth <jgroth@dsl.pipex.com> wrote:
>>
>>>Oct 18 18:03:16 lion kernel: hdg: dma timeout retry: error=0x40 {
>>>UncorrectableError }, LBAsect=53500655, sector=53500520
> 
> 
> The Uncorrectable Error is a dead give away.  You have a bad sector on
> your drive.
> 
How am I supposed to fix those blocks? I've tried with e2fsck -c -c -y 
/dev/md0  but that yields the following printout in the log.

Oct 19 18:12:13 lion kernel: hdg: dma_timer_expiry: dma status == 0x61
Oct 19 18:12:23 lion kernel: hdg: dma timeout retry: status=0x51 { 
DriveReady SeekComplete Error }
Oct 19 18:12:23 lion kernel: hdg: dma timeout retry: error=0x40 { 
UncorrectableError }, LBAsect=156145, sector=156064
Oct 19 18:12:23 lion kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 156064
Oct 19 18:12:24 lion kernel: blk: queue c8828afc, I/O limit 4095Mb (mask 
0xffffffff)
Oct 19 18:12:29 lion kernel: hdg: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Oct 19 18:12:29 lion kernel: hdg: read_intr: error=0x40 { 
UncorrectableError }, LBAsect=156145, sector=156082
Oct 19 18:12:29 lion kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 156082
Oct 19 18:12:49 lion kernel: hdg: dma_timer_expiry: dma status == 0x61
Oct 19 18:12:59 lion kernel: hdg: dma timeout retry: status=0x51 { 
DriveReady SeekComplete Error }
Oct 19 18:12:59 lion kernel: hdg: dma timeout retry: error=0x40 { 
UncorrectableError }, LBAsect=156145, sector=156072
Oct 19 18:12:59 lion kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 156072

This goes on for a while and after that the following appears in the log.
Oct 19 18:14:29 lion kernel:
Oct 19 18:14:29 lion kernel: hdg: status timeout: status=0xd0 { Busy }
Oct 19 18:14:29 lion kernel:
Oct 19 18:14:29 lion kernel: hdh: DMA disabled
Oct 19 18:14:29 lion kernel: PDC202XX: Secondary channel reset.
Oct 19 18:14:29 lion kernel: ide3: reset: success
Oct 19 18:14:34 lion kernel: hdh: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }
Oct 19 18:14:34 lion kernel:
Oct 19 18:14:34 lion kernel: hdh: status timeout: status=0xd0 { Busy }
Oct 19 18:14:34 lion kernel:
Oct 19 18:14:34 lion kernel: PDC202XX: Secondary channel reset.
Oct 19 18:14:34 lion kernel: ide3: reset: success
Oct 19 18:14:40 lion kernel: hdh: status error: status=0x58 { DriveReady 
SeekComplete DataRequest }
Oct 19 18:14:40 lion kernel:
Oct 19 18:14:40 lion kernel: hdh: status timeout: status=0xd0 { Busy }

And that goes on as long as e2fsck runs. So it takes forever just to 
check a couple of blocks and as it has to check > 78E6 blocks it will 
take weeks.

Is there something wrong with the drivers or the controller or the hd:s?

Please CC me as I'm not on the list.

/Johan
