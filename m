Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTDCVKG 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263438AbTDCVKG 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:10:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42147 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263434AbTDCVKD 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 16:10:03 -0500
Date: Thu, 3 Apr 2003 13:21:37 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org, arrays@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-Id: <20030403132137.746cf532.rddunlap@osdl.org>
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640451339C@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E10640451339C@cceexc18.americas.cpqcorp.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003 14:18:57 -0600 "Cameron, Steve" <Steve.Cameron@hp.com> wrote:

| 
| > This patch to 2.5.66 reduces stack usage in ida_ioctl() by about
| > 0x500 bytes (on x86).
| 
| Looks ok to me, (but i haven't tried it.)

Me either (-ENOHARDWARE).
 
| > There is a possibility that the allocation here should be done one time
| > only and the buffer pointer saved for re-use instead of allocating it
| > on each call to ida_ioctl.  If that's desirable, I'll have a few
| > questions.
| 
| No, I don't think so.  I think we should
| allow for the possibllity of concurrent calls 
| to this ioctl.  (whether linux allows it is 
| another question.  I think it used to be the case
| that only one ioctl could get in at a time... I can't
| recall if it's still that way.)

Well, my questions were along those lines, like:
. allocate a buffer per hba or per disk?
. how much is ida_ioctl() [passthru] used?
. it's not on a normal(!?!) read path, is it?
  if so, using kmalloc() that could fail would be a bad idea.

--
~Randy
