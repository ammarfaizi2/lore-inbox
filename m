Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290553AbSBFOKN>; Wed, 6 Feb 2002 09:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290561AbSBFOKD>; Wed, 6 Feb 2002 09:10:03 -0500
Received: from ns.suse.de ([213.95.15.193]:51723 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290553AbSBFOJu>;
	Wed, 6 Feb 2002 09:09:50 -0500
Date: Wed, 6 Feb 2002 15:09:49 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206150949.A10871@wotan.suse.de>
In-Reply-To: <p73ofj2lpdg.fsf@oldwotan.suse.de> <E16YSpV-0005Es-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YSpV-0005Es-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:13:45PM +0000, Alan Cox wrote:
> > glibc 2.3 seems to plan to use segment register based thread local data for 
> > even non threaded programs, so it would be a good idea to optimize LDT 
> > allocation a bit (= not allocate 64K of vmalloc space every time 
> > sys_modify_ldt is called - there is only 8MB of it) 
> 
> I think it would be a good idea to modify the glibc authors in that case.
> The ldt costs real performance on task switches. It would be very dumb of
> glibc to use it except when justified in the bigger picture - ie threaded
> apps

Are you sure it does? LGDT with non zero argument shouldn't be that costly. 
The %fs switching adds some locked cycles for reloading the segment cache, 
but because Windows uses that I would it expect to be reasonably optimized 
on CPUs. 

I actually tried to complain because on x86-64 it is more costly, but to
no avail. 

-Andi
