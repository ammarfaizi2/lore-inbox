Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967856AbWK3Tzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967856AbWK3Tzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967865AbWK3Tzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:55:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:19152 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S967856AbWK3Tzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:55:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=nDfIREZbo+9KMSsc8+dWx3O0vxcg5sYZ/BY4jtGr+2Kx+bMzVKtuxNaj6X92QlGjqbNTYvfbUf3aGMjzeBP+Bbo4aET67M9yfYxVX2lCDCqsqShC8Ii7+zalBpnmYyGfTohFcZdrJHm3UO6Ofn3UdOqi1ISXiDj4OlYnZvGNDLg=
Message-ID: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Date: Thu, 30 Nov 2006 12:55:46 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
To: NeilBrown <neilb@suse.de>, "Jeff Garzik" <jeff@garzik.org>,
       "Chris Leech" <christopher.leech@intel.com>, akpm@osdl.org
Subject: [PATCH 00/12] md raid acceleration and the async_tx api
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux RAID Mailing List" <linux-raid@vger.kernel.org>,
       "Olof Johansson" <olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 383842d381e13156
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest version of the raid acceleration patch set.  Since
the last release I have created the async_tx api to address the
concerns raised by Neil and Jeff.  With this api in place the raid5
asynchronous and synchronous paths are no longer separated, i.e. there
are no hardware specific concerns in the raid code.

The async_tx api is proposed as a special dmaengine management client
that allows offload engines to be used for bulk memory
transfers/transforms, and fallback to synchronous routines when an
engine is not present.

This implementation has been tested on iop13xx and iop33x platforms in
both the synchronous case and the asynchronous case with the iop-adma
driver.  The changes to the ioatdma driver have only been compile
tested, and testing NET_DMA with iop-adma is pending.

Please consider for -mm.  These patches are against 2.6.19.

Dan Williams:
      dmaengine: add base support for the async_tx api
      dmaengine: add the async_tx api
      dmaengine: driver for the iop32x, iop33x, and iop13xx raid engines
      md: add raid5_run_ops and support routines
      md: workqueue for raid5 operations
      md: move write operations to raid5_run_ops
      md: move raid5 compute block operations to raid5_run_ops
      md: move raid5 parity checks to raid5_run_ops
      md: satisfy raid5 read requests via raid5_run_ops
      md: use async_tx and raid5_run_ops for raid5 expansion operations
      md: raid5 io requests to raid5_run_ops
      md: remove raid5 compute_block and compute_parity5

Regards,
Dan
