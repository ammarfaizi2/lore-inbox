Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272902AbRIMH1P>; Thu, 13 Sep 2001 03:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272905AbRIMH1G>; Thu, 13 Sep 2001 03:27:06 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:17389 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S272902AbRIMH0w>; Thu, 13 Sep 2001 03:26:52 -0400
Date: Thu, 13 Sep 2001 10:27:30 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac10 st driver (DLT)
In-Reply-To: <200109130501.PAA08913@hadron.ansto.gov.au>
Message-ID: <Pine.LNX.4.33.0109131023240.15705-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Ian Crakanthorp wrote:

>
> I am trying to read from a DLT4000 tape.  The device is found and mt can
> talk to it.  But if I try a dd I get:
>
> dd if=/dev/st0 of=/tmp/tape.out bs=16k
> dd: reading `/dev/st0': Cannot allocate memory
> 0+0 records in
> 0+0 records out
>
I have exchanged private email with Ian. The problem in this case was
that the first block on the tape was larger than 16 kB. In this case the
2.4 tape driver returns error ENOMEM (not the most informative error code
but this is what the other Unices return). (The 2.2 driver silently ignores
this error.) With larger byte count dd succeeds and so there is no problem
in the kernel.

	Kai


