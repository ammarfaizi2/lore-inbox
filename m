Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317219AbSF1TYs>; Fri, 28 Jun 2002 15:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSF1TYr>; Fri, 28 Jun 2002 15:24:47 -0400
Received: from code13.unixpunx.org ([205.158.23.142]:56043 "HELO
	code13.unixpunx.org") by vger.kernel.org with SMTP
	id <S317144AbSF1TYq>; Fri, 28 Jun 2002 15:24:46 -0400
Reply-To: ew@unixpunx.net
From: ew@unixpunx.net
To: cdeng@io.iol.unh.edu
Subject: Re: kernel BUG
Cc: linux-kernel@vger.kernel.org
Date: Fri, 28 Jun 2002 12:26:50 -700
Message-Id: <3d1cb87a967243.98166500@>
X-Authenticated-IP: [12.81.77.212]
X-Mailer: ePOP  1.21 R2 (http://www.UniRechner.de/)
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-27 at 14:23, Chaoyang Deng wrote:
>
>Hi,
>
>I am working on an iSCSI target driver with a Fibre Channel disk. After I
>updated my OS to linux7.3 with kernel 2.4.18-3, I got problem: my driver
>will crash my box. I am not sure if it is a bug in my code or in the
>Qlogic Fibre Channel driver or in the kernel. Could anyone give me a hint?
>

The BUG() is popping in include/asm/pci.h:pci_map_sg(). If either sg_list.address
or sg_list.page is not NULL,  or both are NULL the BUG() is called.  The reason
for this is around 2.4.13-pre2 bounce buffers along with a nasty memcpy where added
in linux/drivers/scsi/scsi_lib.c:scsi_io_completion() to scatterlists for HighMemIO
support, along with two extra members (page & offset) to struct scatterlist in
include/linux/scatterlist.h.

                                          Eric Weiss

___________________________________________________________

http://webmail.unixpunx.org - Free mail for hackers, free mail for the punks.

