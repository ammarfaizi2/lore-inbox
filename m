Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264320AbRFOKbs>; Fri, 15 Jun 2001 06:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRFOKbi>; Fri, 15 Jun 2001 06:31:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37646 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264320AbRFOKb2>;
	Fri, 15 Jun 2001 06:31:28 -0400
Date: Fri, 15 Jun 2001 11:30:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reg file system hash function
Message-ID: <20010615113038.B31502@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.10.10106141549470.11393-100000@blrmail> <Pine.LNX.4.10.10106151546310.5980-100000@blrmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106151546310.5980-100000@blrmail>; from sathish.j@tatainfotech.com on Fri, Jun 15, 2001 at 03:52:52PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 03:52:52PM +0530, SATHISH.J wrote:
> In the vfs layer when we see the lookup_dentry() function code we see that
> a part of the code checks whether low level filesystem wants to use its
> own hash. the part odf the code that calls the filesystem dependant
> hashing is  "error = base->d_op->d_hash->(base,&this);". Why should it
> callfilesystem dependant hashing. What is the main purpose of hashing
> here.
> Please help me with these details. 

It is used in two cases.  If a filesystem has:

1. case-insensitive filenames (its much better to have the names 'FOO' and
   'foo' refer to the same dentry, since they refer to the same file)

2. a limited filename length and your filesystem truncates names (on a
   non-vfat filesystem 'dosfilen.ame' and 'dosfilename.ame' would be the
   same file and the same dentry structure).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

