Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314489AbSDRXQW>; Thu, 18 Apr 2002 19:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSDRXQV>; Thu, 18 Apr 2002 19:16:21 -0400
Received: from gear.torque.net ([204.138.244.1]:59652 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S314489AbSDRXQU>;
	Thu, 18 Apr 2002 19:16:20 -0400
Message-ID: <3CBF52AF.38B7DC49@torque.net>
Date: Thu, 18 Apr 2002 19:11:43 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.8-dj1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> wrote:

<snip/>
> Right now, BIO_MAX_SECTORS is only 64k, and IDE can
> take twice that.  I'm not sure what the largest
> request size is for SCSI - certainly 128k.

Scatter gather lists in the scsi subsystem have a max
length of 255. The actual maximum size is dictated by 
the HBA driver (sg_tablesize). The HBA driver can
further throttle the size of a single transfer with
max_sectors.

Experiments with raw IO (both in 2.4 and 2.5) indicate
that pages are not contiguous when the scatter gather 
list is built. On i386 this limits the maximum transfer
size of a single scsi command to just less than 1 MB.

Doug Gilbert
