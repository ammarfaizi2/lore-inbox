Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVFHJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVFHJOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVFHJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 05:14:50 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:30615 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262148AbVFHJOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 05:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=evl5z9nFdpeOQzyU7VIz2acFrpuzcdgBg0BmWTCY7Xg/gz9slqa9nC91VdqKnngP1o79zymZn7U+Yg08tO7XE1rdGhOCqRMD5+sNhOZr7aEgT5SsZEl31gpOdKXvzkJpW7m7pZtMKQ+b/v76EBF9SuwSIudDr8sBxfetHij0z/Y=
Message-ID: <58cb370e05060802149b2f530@mail.gmail.com>
Date: Wed, 8 Jun 2005 11:14:45 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: info@a-wing.co.uk
Subject: Re: sis5513.c patch
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <58cb370e05060801585b49020e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A621BC.7040607@a-wing.co.uk>
	 <58cb370e05060800276f3fc29c@mail.gmail.com>
	 <42A6AB1B.8000800@a-wing.co.uk>
	 <58cb370e05060801585b49020e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Andrew, please remove this patch from -mm queue. ]

On 6/8/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
> > >
> > >>Hi,
> > >
> > >
> > > Hi,
> > >
> >
> > Hi again,
> >
> > >
> > >>I'm not sure if a similar patch has been submitted or not, but here is a
> > >>patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
> > >>chipset combo.
> > >
> > >
> > > This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID
> > > is common for almost all SiS IDE controllers and is already present in
> > > sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver
> > > will try to use ATA_133 on all _unknown_ IDE controllers.  You need
> > > to add PCI ID of the Host chipset (lspci should reveal it) instead.

Second look into sis5513.c and another problem turns out - patch breaks 
support for IDE controllers integrated into 961 and 961B South Bridges
(ATA_133 is used instead of ATA_100 and ATA133a).

For unknown Host Bridges driver checks for presence of 961/961B/962/963
South Bridges by checking true device ID (please see sis5513.c for details) 
and assigns 'chipset_family' accordingly (ATA_100/ATA_133a or ATA_133).

You have 965L South Bridge so probably it has newer true device ID 
and  may also require different programming sequence.

> Could you please send full lspci -vvv output?

and lspci -xxx

Bartlomiej
