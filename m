Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277225AbRJDUvB>; Thu, 4 Oct 2001 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277224AbRJDUuv>; Thu, 4 Oct 2001 16:50:51 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:20484 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S277222AbRJDUuj> convert rfc822-to-8bit; Thu, 4 Oct 2001 16:50:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
Subject: Is kiobuf->end_io still used?
Date: Thu, 4 Oct 2001 15:49:43 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106410AA61@cceexc18.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Is kiobuf->end_io still used?
Thread-Index: AcFNFhgAzz2lV/FgRAWhFERv9GL7DQ==
From: "Bond, Andrew" <Andrew.Bond@COMPAQ.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Oct 2001 20:49:44.0124 (UTC) FILETIME=[18A60FC0:01C14D16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the end_io field from the kiobuf structure still used?

The only usage of it that I can find is in fs/iobuf.c:end_kio_request().

	if (kiobuf->end_io)
		kiobuf->end_io(kiobuf);

I can't find code in the kernel that sets the end_io field.  The kiobuf
structure should be hidden from drivers, so a driver shouldn't be
setting it.  The callback routines for the IO are set in the individual
buffer headers.  So far it looks like this check in end_kio_request()
always does nothing because the end_io field is initialized as 0.

Am I missing something?

Thanks,
Andrew
