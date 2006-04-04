Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWDDVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWDDVGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWDDVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:06:46 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:47754 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750879AbWDDVGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:06:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm1: mlockall() regression on x86_64
Date: Tue, 4 Apr 2006 22:53:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060404014504.564bf45a.akpm@osdl.org>
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604042253.06378.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 10:45, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/

With this kernel mlockall(MCL_CURRENT | MCL_FUTURE) returns -EFAULT if called
by root (unconditionally, it seems) on x86_64.

On my box the output of:

#include <sys/mman.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

int main()
{
	int ret;

	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
	if (ret < 0)
		printf("%s\n", strerror(errno));

	return 0;
}

is "Bad address", if run by root.

Greetings,
Rafael
