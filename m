Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVD1UIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVD1UIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVD1UIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:08:45 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4260 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262238AbVD1UIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:08:44 -0400
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should
	return -ENOSYS
From: Robert Love <rml@novell.com>
To: linux-os@analogic.com
Cc: dtor_core@ameritech.net, Chris Wright <chrisw@osdl.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0504281551420.29750@chaos.analogic.com>
References: <200504280030.10214.dtor_core@ameritech.net>
	 <20050428172659.GA18859@kroah.com>
	 <20050428173744.GO23013@shell0.pdx.osdl.net>
	 <d120d500050428105153ab13b1@mail.gmail.com>
	 <Pine.LNX.4.61.0504281551420.29750@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 16:08:17 -0400
Message-Id: <1114718897.6682.101.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:56 -0400, Richard B. Johnson wrote:

> Perhaps...
> ENOSPC, i.e., the device is full. This is the usual return value
> for a CD/ROM and `df` always shows it's full even if it has
> one small file.

But there is space on the backing device.  Given two files on the same
file system, one should not be returning ENOSPC on write and the other
succeeding.

> The only thing that really makes sense is EPERM but it is usually
> associated with permissions rather than if an operation is permitted.

EPERM isn't even a valid SUSv3 return for write(2).  Permissions don't
apply to writes, only opens (and, thus, this is a valid return for
open(2)).

The answer has already been suggested: EACCESS or EIO.

	Robert Love


