Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSFOJX4>; Sat, 15 Jun 2002 05:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFOJXz>; Sat, 15 Jun 2002 05:23:55 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:12042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315210AbSFOJXz>; Sat, 15 Jun 2002 05:23:55 -0400
Date: Sat, 15 Jun 2002 10:23:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kevin Easton <s3159795@student.anu.edu.au>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020615102352.B13440@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0206150830190.1185-100000@localhost.localdomain> <20020615191230.A22499@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 07:12:30PM +1000, Kevin Easton wrote:
> Hmm.. so how do such pages get marked dirty on architectures that don't
> do it in hardware ("most RISC architectures" according to a comment in
> memory.c)? Is the entire mapping made dirty when the write permissions
> are added?

No.  You only give user space write access when the write access _and_
"Linux dirty bit" are set.  This means you fault when user space tries
to write to the page, which means you can set the dirty bit.  This is
what the following code is doing (if write_access is required and the
pte already has write permission, then set the dirty bit):

        if (write_access) {
                if (!pte_write(entry))
                        return do_wp_page(mm, vma, address, pte, pmd, entry);

                entry = pte_mkdirty(entry);
	}

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

