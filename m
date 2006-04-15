Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWDOAeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWDOAeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWDOAeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:34:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52920 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751447AbWDOAeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:34:02 -0400
Subject: Re: [PATCH] make: add modules_update target
From: Dustin Kirkland <dustin.kirkland@us.ibm.com>
Reply-To: Dustin Kirkland <dustin.kirkland@us.ibm.com>
To: Avi Kivity <avi@argo.co.il>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kylene Jo Hall <kjhall@us.ibm.com>,
       kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <443FF1D9.4060904@argo.co.il>
References: <1145027216.12054.164.camel@localhost.localdomain>
	 <20060414170222.GA19172@thunk.org>  <443FE350.5040502@argo.co.il>
	 <1145039347.3074.11.camel@localhost.localdomain>
	 <443FF1D9.4060904@argo.co.il>
Content-Type: text/plain
Organization: IBM
Date: Fri, 14 Apr 2006 19:33:37 -0500
Message-Id: <1145061217.4001.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 22:02 +0300, Avi Kivity wrote:
> Use rsync only if it is available:
> 
>     rsync-available := $(shell rsync --version > /dev/null 2>&1 && echo y)
>     copy := $(if $(rsync-available), rsync --delete, cp)
> 
>     modules_install:
>                [...]
>                $(copy) source target

Actually, rsync --delete is not a viable option either.  If you first
build a kernel with a particular item built as a module, and then
afterward rebuild with the same item as built-in (or not at all),
the .ko file remains in your kernel build tree (ie, it won't be deleted
on the source such that the --delete would have your desired effect).

Furthermore, rsync's performance is considerably worse in my testing
than "cp -u", almost back to the original performance of the "rm -rf, cp
all" of the original modules_install.  (Note that I tested, rsync's
default, checksum, mod-times, and size-only.)

:-Dustin

