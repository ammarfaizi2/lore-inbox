Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTHTTbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbTHTTbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:31:11 -0400
Received: from webmail.altiris.com ([64.90.198.5]:16989 "EHLO
	webmail.altiris.com") by vger.kernel.org with ESMTP id S262169AbTHTTbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:31:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 48-bit Drives Incorrectly reporting 255 Heads?
Date: Wed, 20 Aug 2003 13:31:08 -0600
Message-ID: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 48-bit Drives Incorrectly reporting 255 Heads?
Thread-Index: AcNnUZHIlzrV20pMQz2H5RAqp7PARg==
From: "John Riggs" <jriggs@altiris.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Aug 2003 19:31:09.0328 (UTC) FILETIME=[9B600900:01C36751]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  With the 2.4.20 kernel, I have a 40GB disk with 240 heads, with 48-bit
mode enabled. The Linux ide driver automatically declares that anything
with 48-bit mode enabled has 255 heads. This is a problem, as I am
writing a utility to fix up a Windows PBR, and the PBR relies on the
head count as counted by the BIOS.
  The Linux code in question is in ide-disk.c:

  if (id->cfs_enable_2 & 0x0400) {
    .
    drive->head = drive->bios_head = 255;
    .
  }

  What I would like to do is change the above to:

  if (id->cfs_enable_2 & 0x0400) {
    .
    drive->head = 255;
    .
  }

  Thereby not changing the bios head count. My initial tests seem to
have worked okay, with the correct geometry getting reported. Can
anybody point out to me why this will break something else?
  Two more specific questions are:
    1) Will this break drives > 137 GB?
    2) Why would the head count be set to 255 in the first place?

Thank you,
John Riggs
