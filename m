Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVJKJ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVJKJ0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVJKJ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:26:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62698 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751436AbVJKJ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:26:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Karthik Sarangan <karthiks@cdac.in>
Subject: Re: AIO!!
Date: Tue, 11 Oct 2005 12:25:35 +0300
User-Agent: KMail/1.8.2
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <434A6EFC.4010100@cdac.in> <20051010160856.GI13986@kvack.org> <434B47C1.60106@cdac.in>
In-Reply-To: <434B47C1.60106@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510111225.35838.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 October 2005 08:04, Karthik Sarangan wrote:
>  > Benjamin LaHaise wrote:
> > O_DIRECT buffers must be aligned on block sized boundaries (minimum 512 
> > bytes).  Check the actual return code from the aiocb and you'll find that 
> > it is likely -EINVAL, no -EINPROGRESS.  See the man page for 
> > posix_memalign() to properly align the pointer.
> 
> EEP!! I forgot all about buffer alignment!! Thanks for pointing it out

Why do you constantly shout?

> ------------------
> Two more questions.
> 
> 1. Is aio_fsync of any use while 'aio_read'ing and 'aio_write'ing to
>     a 'raw' device or a '/dev/sdb' with O_DIRECT?

I suspect you did not do some research first.

> 2. I have an Ultra320 SCSI disk whose datasheet says it has a max.
>     possible throughput of 78MBps
> 
>     I did a 'aio_write' onto '/dev/sdb' with O_DIRECT.
>     Following are some throughput values.
> 
>     Buffer for IO   |  Avg Speed
>     (in KBytes)     |
>     ----------------O-----------
>     Upto 512KB      |  69MBps
>     1024KB          |  125MBps
>     2048KB          |  250MBps
>     4096KB          |  500MBps
>     8192KB          |  1GBps		-- What the !! --

Most probably bug in your program.

>     Buffer cache does not come into consideration.
> 
>     Does this mean that the SCSI lower layer (aic79xx) can transfer data
>     only upto 512 KB?

It means that you are in dire need of reading this:

http://www.catb.org/~esr/faqs/smart-questions.html

--
vda
