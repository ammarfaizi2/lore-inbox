Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288360AbSACWpW>; Thu, 3 Jan 2002 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288362AbSACWpM>; Thu, 3 Jan 2002 17:45:12 -0500
Received: from zok.SGI.COM ([204.94.215.101]:59554 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S288360AbSACWpA>;
	Thu, 3 Jan 2002 17:45:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 03 Jan 2002 17:11:37 CDT."
             <Pine.GSO.4.21.0201031653420.23693-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 Jan 2002 09:44:49 +1100
Message-ID: <22327.1010097889@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 17:11:37 -0500 (EST), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Fri, 4 Jan 2002, Keith Owens wrote:
>
>> * Mount COW layer over clean tree.
>> * Edit a file, writing to the COW layer.
>> * Build the kernel.
>> * Decide that you don't want the change, delete the COW version,
>>   exposing the original version of the file, timestamp goes backwards.
>
>ITYM "creating a whiteout entry".  unlink() on unionfs doesn't expose
>the underlying object.

It does in kbuild 2.5.  You have a pristine source tree, start a
development layer, edit files, build a kernel, decide your edit was
wrong, delete the updated version, expose the original and kbuild 2.5
still gets it right.  IMHO that model better fits kernel development.

The whiteout model makes it more difficult to revert to the standard
kernel, you have to copy the original code to your writeable layer to
back out changes.  To satisfy the broken make design, you cannot copy
with timestamp.  When the base layer changes to a new release, the COW
version does not get upgraded, even though it is supposed to be
identical to the base layer.

Again, I am not disagreeing with unionfs, it has its uses.  kbuild
using make and relying solely on timestamps to detect changes is not
one of them.  Especially when kbuild has to run on other operating
systems.

