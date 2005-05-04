Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVEEAoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVEEAoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 20:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVEEAoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 20:44:04 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:61950 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261982AbVEEAnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 20:43:53 -0400
Subject: Re: System call v.s. errno
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 04 May 2005 10:22:02 -0400
Message-Id: <1115216522.6053.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 09:22 -0400, Richard B. Johnson wrote:
> Does anybody know for sure if global 'errno' is supposed to

errno is a glibc level thing really, and in recent glibc tehre is no
global errno anymore, only a per thread errno.

> The answer is not obvious because the 'C' runtime library
> doesn't really give access to 'errno' instead it is dereferenced
> off some pointer returned from a function called __errno_location().

yeah to make sure you get the per thread errno instead. Any reasonable
sane code (and all standards conforming code) just deals with that fine.
The case that is known to break is if your app has it's own

extern int errno;

in it, instead of using the proper header to get it.



