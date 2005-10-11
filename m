Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVJKFKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVJKFKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJKFKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:10:44 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:9909 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S1751358AbVJKFKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:10:43 -0400
Message-ID: <434B47C1.60106@cdac.in>
Date: Tue, 11 Oct 2005 10:34:01 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: AIO!!
References: <434A6EFC.4010100@cdac.in> <20051010160856.GI13986@kvack.org>
In-Reply-To: <20051010160856.GI13986@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Benjamin LaHaise wrote:
> O_DIRECT buffers must be aligned on block sized boundaries (minimum 512 
> bytes).  Check the actual return code from the aiocb and you'll find that 
> it is likely -EINVAL, no -EINPROGRESS.  See the man page for 
> posix_memalign() to properly align the pointer.
> 

EEP!! I forgot all about buffer alignment!! Thanks for pointing it out

:)

------------------

Two more questions.

1. Is aio_fsync of any use while 'aio_read'ing and 'aio_write'ing to
    a 'raw' device or a '/dev/sdb' with O_DIRECT?

2. I have an Ultra320 SCSI disk whose datasheet says it has a max.
    possible throughput of 78MBps

    I did a 'aio_write' onto '/dev/sdb' with O_DIRECT.
    Following are some throughput values.

    Buffer for IO   |  Avg Speed
    (in KBytes)     |
    ----------------O-----------
    Upto 512KB      |  69MBps
    1024KB          |  125MBps
    2048KB          |  250MBps
    4096KB          |  500MBps
    8192KB          |  1GBps		-- What the !! --

    Buffer cache does not come into consideration.

    Does this mean that the SCSI lower layer (aic79xx) can transfer data
    only upto 512 KB?

