Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263755AbREYOJD>; Fri, 25 May 2001 10:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263754AbREYOIy>; Fri, 25 May 2001 10:08:54 -0400
Received: from ns.suse.de ([213.95.15.193]:22798 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263755AbREYOIi>;
	Fri, 25 May 2001 10:08:38 -0400
Date: Fri, 25 May 2001 16:07:29 +0200
From: Andi Kleen <ak@suse.de>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
Message-ID: <20010525160729.B32273@gruyere.muc.suse.de>
In-Reply-To: <24688.990773627@kao2.melbourne.sgi.com> <01052516035700.01561@idun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01052516035700.01561@idun>; from Oliver.Neukum@lrz.uni-muenchen.de on Fri, May 25, 2001 at 04:03:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 04:03:57PM +0200, Oliver Neukum wrote:
> > A small overflow of the kernel stack overwrites the struct task at the
> > bottom of the stack, recovery is dubious at best because we rely on
> > data in struct task.  A large overflow of the kernel stack either
> > corrupts the storage below this task's stack, which could hit anything,
> > or it gets a stack fault.
> 
> Is there a reason for the task structure to be at the bottom rather than the 
> top of these two pages ?

This way you save one addition for every current access; which adds to 
quite a few KB over the complete kernel. 

-Andi
