Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbUKDRyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUKDRyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUKDRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:53:44 -0500
Received: from hera.kernel.org ([63.209.29.2]:60371 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262317AbUKDRqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:46:09 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: stdint constants
Date: Thu, 4 Nov 2004 17:45:58 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cmdpsm$45o$1@terminus.zytor.com>
References: <OF1C112AC2.560EA5F6-ONC1256F41.0049C0DE@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1099590358 4281 127.0.0.1 (4 Nov 2004 17:45:58 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 4 Nov 2004 17:45:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <OF1C112AC2.560EA5F6-ONC1256F41.0049C0DE@telemotive.de>
By author:    roman.fietze@telemotive.de
In newsgroup: linux.dev.kernel
>
> Hello,
> 
> First of all: sorry for using Notes MUA, but cannot route to kernel.org 
> due to NJABL.
> 
> Allthough many books recommend using the types uint8_t to uint64_t as
> well as their signed counterparts, I could not find the MIX/MAX values
> for those types in any kernel include file.
> 
> Tested on a 2.4 ARM/PPC/I386 kernel with gcc 3.0.4/3.2.2/3.3.2. Not
> tested on any 64 bit architecture.
> 
> Any comments to this patch?
> 

Yes.  Long long is a ISO C99 type guaranteed to be at least 64 bits.
Thus, 

#if defined(__GNUC__) && !defined(__STRICT_ANSI__)

is wrong; it's in fact actively harmful.

Furthermore, this should only be used by the kernel, since this comes
from <stdint.h> in userspace.

<stdint.h> really should be a compiler-provided header file.  Sigh.

	-hpa
