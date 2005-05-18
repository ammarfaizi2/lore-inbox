Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVERPBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVERPBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVERO6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:58:02 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:41704 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262289AbVERO4l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:56:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 3/8] ppc64: add a watchdog driver for rtas
Date: Wed, 18 May 2005 16:39:51 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       Utz Bacher <utz.bacher@de.ibm.com>, Wim Van Sebroeck <wim@iguana.be>
References: <200505132117.37461.arnd@arndb.de> <200505180914.44336.arnd@arndb.de> <20050518144534.GA3723@otto>
In-Reply-To: <20050518144534.GA3723@otto>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505181639.52415.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 18 Mai 2005 16:45, Nathan Lynch wrote:
> 
> > A semaphore would also be the wrong approach since we don't want
> > processes to block but instead to fail opening the watchdog twice.
> 
> I should have been more explicit.  What I had in mind was using
> down_trylock and returning -EBUSY if it failed.

Well, that's also pointless. If the only operations you ever do
on a semaphore are down_trylock() and up(), you end up using
only the atomic variable in there while wasting a few bytes of
extra memory for storing the wait queue head ;-)

	Arnd <><
