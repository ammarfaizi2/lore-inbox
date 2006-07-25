Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWGYE4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGYE4c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGYE4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:56:31 -0400
Received: from [212.70.37.245] ([212.70.37.245]:15368 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932455AbWGYE43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:56:29 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: CFQ will be the new default IO scheduler - why?
Date: Tue, 25 Jul 2006 07:56:49 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200607241857.43399.a1426z@gawab.com> <1153758806.3043.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1153758806.3043.55.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607250756.49071.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > > Should there be a default scheduler per filesystem?  As some
> > > filesystems may perform better/worse with one over another?
> >
> > It's currently perDevice, and should probably be extended to perMount.
>
> Hi,

Hi!

> per mount is going to be "not funny". I assume the situation you are
> aiming for is the "3 partitions on a disk, each wants its own elevator".
> The way the kernel currently works is that IO requests the filesystem
> does are first flattened into an IO for the entire device (eg the
> partition mapping is done) and THEN the IO scheduler gets involved to
> schedule the IO on a per disk basis.

IC.  That probably explains why concurrent io-procs have such a hard time 
getting through to the disk.  They probably just hang in the flatting phase, 
waiting for something to take care of their requests.

> The 2.4 kernel did this the other way around, and it was really a bad
> idea (no fairness, less optimal scheduling all around due to less
> visibility into what the disk is really doing, several hardware
> properties such as TCQ depth that affect scheduling IOs are truely per
> disk not per partition etc etc)
>
> So I don't think it's likely that per mount is really an option right
> now..

Probably true as it stands right now, but extending io-sched semantics to be 
filesystem aware in the "flattening/partition mapping" phase could improve 
performance a lot.

Thanks!

--
Al


