Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTEBI4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTEBI4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:56:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261985AbTEBI4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:56:11 -0400
Date: Fri, 2 May 2003 10:08:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bodo Rzany <bodo@rzany.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Message-ID: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0305021018070.493-100000@joel.ro.ibrro.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305021018070.493-100000@joel.ro.ibrro.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 11:06:32AM +0200, Bodo Rzany wrote:
> PROBLEM:
> 	Hex/Octal decoding with sscanf from kernel library does not work
> 	within kernel 2.4.20
> 
> DESCRIPTION:
> 	Line 570 in lib/vsprintf.c
> 
> 			14677 11. Okt 2001  vsprintf.c
> 
> 	holds '	base = 10; '
> 
> 	which prevents the real conversion routines ('simple_strtoul' a.s.o.)
> 	from decoding numbers from bases other than 10.

It's not a problem, it's standard-mandated behaviour.

>From vsscanf(3):
       The following conversions are available:
...
       d      Matches  an  optionally signed decimal integer; the next pointer
              must be a pointer to int.
...
       i      Matches an optionally signed integer; the next pointer must be a
              pointer  to  int.   The  integer is read in base 16 if it begins
              with `0x' or `0X', in base 8 if it begins with `0', and in  base
              10  otherwise.   Only characters that correspond to the base are
              used.

IOW, %d _does_ mean base=10.  base=0 is %i.  That goes both for kernel and
userland implementations of scanf family (and for any standard-compliant
implementation, for that matter).
