Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSDSId7>; Fri, 19 Apr 2002 04:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDSId6>; Fri, 19 Apr 2002 04:33:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35852 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311919AbSDSId6>; Fri, 19 Apr 2002 04:33:58 -0400
Subject: Re: Bio pool & scsi scatter gather pool usage
To: joe@fib011235813.fsnet.co.uk (Joe Thornber)
Date: Fri, 19 Apr 2002 09:51:10 +0100 (BST)
Cc: lord@sgi.com (Stephen Lord), akpm@zip.com.au (Andrew Morton),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        peloquin@us.ibm.com (Mark Peloquin), linux-kernel@vger.kernel.org
In-Reply-To: <20020419080814.GA1181@fib011235813.fsnet.co.uk> from "Joe Thornber" at Apr 19, 2002 09:08:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16yU6o-0006h3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is exactly the problem; I don't think it's going to be unusual to
> see volumes that have a variety of mappings.  For example the
> 'journal' area of the lv with a single fast pv, 'small file' area with
> a linear mapping across normal pv's, and finally a 'large file' area
> that has a few slower disks striped together.

Optimise for the sane cases. Remember the lvm can chain bio's trivially
itself. Its a lot cheaper to chain them than unchain them

> The last thing I want in this situation is to split up all the io into
> the lowest common chunk size, in this case the striped area which will
> typically be  < 64k.

The last thing I want is layers of bio support garbage slowing down a 
perfectly sane machine that does not need them...

Alan
