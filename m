Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUGGM3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUGGM3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUGGM3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:29:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264192AbUGGM3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:29:45 -0400
Date: Wed, 7 Jul 2004 08:29:16 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
Message-ID: <20040707122916.GH21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.53.0407070715380.17430@chaos> <20040707114836.29295.qmail@web41103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707114836.29295.qmail@web41103.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:48:36AM -0700, tom st denis wrote:
> --- "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > Tom is correct. A literal constant defaults to 'int'.
> 
> I did a bit more messing around with GCC and it seems in 
> 
> int x = 4;
> if (x == 0xDEADBEEF) { ... }
> 
> It will warn that 0xDEADBEEF is unsigned (which it isn't).  Either
> there is an obscure clause in the C standard [I personally don't have a
> copy of C99 nor do I plan on reading it for this] or GCC cause an
> incorrect diagnostic [which isn't in violation of the standards...]

It is certainly not obscure.
ISO C99 6.4.4.1#5 says:
The type of an integer constant is the first of the corresponding list in
which its value can be represented.

For Octal or Hexadecimal Constant and no suffix, the table lists:
int
unsigned int
long int
unsigned long int
long long int
unsigned long long int

Assuming 32-bit int, 0xdeadbeef has unsigned int type.

For Decimal Constant and no suffix, the table lists only:
int
long int
long long int
and thus assuming 32-bit int and 64-bit long, 3735928559 has long int type,
assuming 32-bit int, 32-bit long and 64-bit long long, 3735928559 has long
int type.

	Jakub
