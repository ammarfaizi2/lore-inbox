Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264288AbRFGCNt>; Wed, 6 Jun 2001 22:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264289AbRFGCNj>; Wed, 6 Jun 2001 22:13:39 -0400
Received: from gear.torque.net ([204.138.244.1]:46090 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S264288AbRFGCNe>;
	Wed, 6 Jun 2001 22:13:34 -0400
Message-ID: <3B1EE2DB.A0AE01FE@torque.net>
Date: Wed, 06 Jun 2001 22:11:39 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Rudo Thomas <rudo@internet.sk>
Subject: Re: kernel oops when burning CDs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tachino wrote:
> At Mon, 4 Jun 2001 22:43:30 +0100 (BST),
> Alan Cox wrote:
> > 
> > > I get an ooops and immediate kernel panic when I break (CTRL-C) cdrecord. I 
> > > can reproduce it anytime. I use 2.4.5-ac series. Obviously, Linus' 2.4.5 is 
> > > fine.
> > > I know, I know. I was supposed to make a serios oops report, BUT I wasn't 
> > 
> > Write down the EIP and the call trace then look them up in System.map. Also
> > include the hardware details. The -ac tree has a newer version of the scsi
> > generic code. It fixes some oopses but in your case it apparently added a new
> > failure case
>
>  Oops occures in SG driver. This patch fixes the problem.

[patch snipped. It looks fine]

Tachino,
Thanks for the patch. Alan Cox has incorporated it in lk 2.4.5-ac9 .
The problem only occurs when the sg driver is built in. [I do my
testing with sg built as a module.]

Currently sg version 3.1.18 is in the ac tree while the previous
version (3.1.17) is in the main branch. The code that oopsed is
there to temporarily bump the sg module count to inhibit rmmod
(and/or autoclean) until all SCSI commands on that device are
finished.

Doug Gilbert
