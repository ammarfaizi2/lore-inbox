Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUFHWKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUFHWKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 18:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbUFHWKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 18:10:49 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29455 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264355AbUFHWKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 18:10:47 -0400
Date: Tue, 8 Jun 2004 15:10:08 -0700
From: Paul Jackson <pj@sgi.com>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/wrapper.h, where does it come from?
Message-Id: <20040608151008.75d01bf0.pj@sgi.com>
In-Reply-To: <40C6295B.10101@blue-labs.org>
References: <40C6295B.10101@blue-labs.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These two files include it.  While compiling the qc-usb module, it's 
> searching for this file.

Could it be they are looking for the Linux 2.4 header file
include/linux/wrapper.h, which contains in its entirety:

====================== begin snip ======================
#ifndef _WRAPPER_H_
#define _WRAPPER_H_

#define mem_map_reserve(p)      set_bit(PG_reserved, &((p)->flags))
#define mem_map_unreserve(p)    clear_bit(PG_reserved, &((p)->flags))

#endif /* _WRAPPER_H_ */
====================== end snip ======================

Without this, I don't see offhand how either of the files:

    sound/oss/au1000.c
    sound/oss/ite8172.c

could be compiled, as they seem to use these mem_map_[un]*reserve() macros.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
