Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVD1RoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVD1RoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVD1RoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:44:08 -0400
Received: from peabody.ximian.com ([130.57.169.10]:1443 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262190AbVD1Rml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:42:41 -0400
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should
	return -ENOSYS
From: Robert Love <rml@novell.com>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20050428172659.GA18859@kroah.com>
References: <200504280030.10214.dtor_core@ameritech.net>
	 <20050428172659.GA18859@kroah.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 13:42:15 -0400
Message-Id: <1114710135.6682.60.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 10:26 -0700, Greg KH wrote:

> What is the POSIX standard for this?  ENOSYS or EACCESS?
> 
> Or anyone have a link that I can look this up at?

ENOSYS isn't defined by SUSv3 (and thus not POSIX) for write(2).

EACCESS is defined only for socket errors, but you could of course
hijack it.  I think it is silly, though, since the open(2) succeeded.
Ideally, the open for writing should fail with EACCESS.

EIO actually means that an internal or physical I/O error occurred, PLUS
it is reserved for implementation-defined errors.  So that makes sense.

The main thing is to _not_ return zero.  That would cause stdio to
resubmit indefinitely.

	Robert Love


