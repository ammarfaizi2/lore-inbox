Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUCSSC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbUCSSC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:02:57 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:29904 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S261915AbUCSSCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:02:54 -0500
From: Mark <mark@harddata.com>
Organization: Hard Data Ltd
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFT] latest libata (includes Silicon Image work)
Date: Fri, 19 Mar 2004 11:02:43 -0700
User-Agent: KMail/1.6
References: <4059EBB8.4010807@pobox.com>
In-Reply-To: <4059EBB8.4010807@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DXzWAuyZ58r9443"
Message-Id: <200403191102.43522.mark@harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_DXzWAuyZ58r9443
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On March 18, 2004 11:34 am, Jeff Garzik <jgarzik@pobox.com> wrote:
> Attached is the latest libata patch against 2.6.x mainline.  Although
> not 100% of content, most of this patch resolves around getting Silicon
> Image into better shape.  As I mentioned in my last post, this patch
> affects all libata users, so plenty of testing is requested.
>
> Silicon Image-related changes:
>
> * Only set/clear the BMDMA bits we care about (got a report last night
> this fixed 3114 for him)
>
> * mask all SATA interrupts
>
> * after determining drive speed, write that information to a special SII
> register Data Transfer Mode
>
> * (style) make port base address setup a loop, shortening the code and
> making the code more readable
>
> * limit SII to UDMA5 (reading info on FreeBSD lists and source code
> scared me about chip errata), mainly related to PATA->SATA bridges.

This patch works pretty well. Here my results of a bonnie++ test on a 4 drive 
array with WD Caviar 74GB Drives on Tyan S2875S with onboard Sil3114.



-- 
Mark Lane, CET mailto:mark@harddata.com 
Hard Data Ltd. http://www.harddata.com 
T: 01-780-456-9771   F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--

--Boundary-00=_DXzWAuyZ58r9443
Content-Type: text/plain;
  charset="utf-8";
  name="bonnie++.out1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="bonnie++.out1"

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
dynamic-109. 20000M 25546  69 39833  20 25538  11 36725  86 80332  19 339.8   2
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
                 16  1535  98 +++++ +++ 17244  95  1646  98 +++++ +++  5744  96
dynamic-109.harddata.net,20000M,25546,69,39833,20,25538,11,36725,86,80332,19,339.8,2,16,1535,98,+++++,+++,17244,95,1646,98,+++++,+++,5744,96

--Boundary-00=_DXzWAuyZ58r9443--
