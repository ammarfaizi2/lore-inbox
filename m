Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSL1R13>; Sat, 28 Dec 2002 12:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbSL1R13>; Sat, 28 Dec 2002 12:27:29 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:972 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S266224AbSL1R12>; Sat, 28 Dec 2002 12:27:28 -0500
Date: Sat, 28 Dec 2002 09:41:49 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E0DE25D.10701@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212281613.gBSGDTn02392@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> OK, the attached is a sketch of an implementation of bus_type operations.

Quick reaction ....

Those signatures look more or less right, at a quick glance,
except that allocating N bytes should pass a __GFP_WAIT flag.
(And of course, allocating a mapping needs a failure return.)

That bus_dma_ops is more of a "vtable" approach, and I confess
I'd been thinking of hanging some object that had internal state
as well as method pointers.  (Call it a "whatsit" for the moment.)

That'd make it possible for layered busses like USB and SCSI
to just reference the "whatsit" from the parent bus in their
layered "struct device" objects. [1]

In many cases that'd just end up being a ref to the "platform
whatsit", eliminating a conditional test from the hot path from
your sketch as well as an entire set of new "platform_*()" APIs.

- Dave

[1] That is, resembling what Benjamin Herrenschmidt suggested:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102389432006266&w=2






