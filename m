Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSAPTHQ>; Wed, 16 Jan 2002 14:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSAPTHH>; Wed, 16 Jan 2002 14:07:07 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:2025 "EHLO aldebaran.sra.com")
	by vger.kernel.org with ESMTP id <S287193AbSAPTGv>;
	Wed, 16 Jan 2002 14:06:51 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15429.52950.224633.511469@irving.iisd.sra.com>
Date: Wed, 16 Jan 2002 14:04:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <a24ft3$4au$1@cesium.transmeta.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
	<a22nc0$2fh$1@cesium.transmeta.com>
	<15429.48638.96256.842851@irving.iisd.sra.com>
	<a24ft3$4au$1@cesium.transmeta.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Followup to:  <15429.48638.96256.842851@irving.iisd.sra.com>
 > By author:    David Garfield <garfield@irving.iisd.sra.com>
 > In newsgroup: linux.dev.kernel
 > > 
 > > Agreed.  However, this work could easily be performed by an insmod
 > > variant that takes a module, a "System.map", and a kernel image, and
 > > produces a cpio file as output instead of passing the data to the
 > > kernel for immediate processing.  The kernel mechanism would then only
 > > need to unpack the pieces, relocate, and make the system calls.
 > > 
 > 
 > How do you know where the running kernel will be allocating address
 > space for the module?

I did say "relocate".  OK, so maybe the correct order is: partial
unpack, first system call, remaining unpack, relocate, second system
call.

Actually, the hard part is intermodule dependencies.  For that, the
issue becomes where the running kernel allocated address space for the
previous modules.  I suppose the insmod variant could process a stream
of modules for loading, but then relocation starts including
double-relocation for a pair of modules...  OK, maybe it is too
complex for the kernel.


--David Garfield
