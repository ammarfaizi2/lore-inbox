Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVBCTTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVBCTTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbVBCTJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:09:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10200 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263123AbVBCTFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:05:22 -0500
In-Reply-To: <20050203024755.1792b6c0.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, nathans@sgi.com,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache pages
 - loop device
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF3C173B68.5174396C-ON88256F9D.0067D54F-88256F9D.0068C36A@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 3 Feb 2005 11:03:53 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 02/03/2005 14:05:20,
	Serialize complete at 02/03/2005 14:05:20
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I did a patch which switched loop to use the file_operations.read/write
>about a year ago.  Forget what happened to it.  It always seemed the 
right
>thing to do..

This is unquestionably the right thing to do (at least compared to what we 
have now).  The loop device driver has no business assuming that the 
underlying filesystem uses the generic routines.  I always assumed it was 
a simple design error that it did.  (Such errors are easy to make because 
prepare_write and commit_write are declared as address space operations, 
when they're really private to the buffer cache and generic writer).

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
