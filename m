Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSHJNZe>; Sat, 10 Aug 2002 09:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSHJNZe>; Sat, 10 Aug 2002 09:25:34 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:19182 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S316898AbSHJNZe>; Sat, 10 Aug 2002 09:25:34 -0400
Date: Sat, 10 Aug 2002 14:12:01 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmapping large files hits swap in 2.4?
Message-ID: <20020810141201.A1868@linux-m68k.org>
References: <1028913975.3832.14.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028913975.3832.14.camel@sonja.de.interearth.com>; from degger@fhm.edu on Fri, Aug 09, 2002 at 07:26:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 07:26:14PM +0200, Daniel Egger wrote:
> Hija,
> 
> I'm currently looking into optimizing GIMPs own swapping algorithm
> by replacing naive file operations by mmap-based ones. Unfortunately
> my test machine (PPC, 256MB) gets hit really hard by mmapping files over
> 100MB into memory: The swap utilization grows up to the file size
> and the machine is completely unresponsive for several seconds up to
> a few minutes. Seemingly the writes to the mmaped area first hit the
> swap and then are read from there again to fit the designated file.
> 
> I'm doing something along the lines of:
> area = mmap (0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

seems like you are doing something else, like hitting all
of the file.

# uname -a
Linux sirizidl.dialin.rrze.uni-erlangen.de 2.4.18 #27 Wed Jul 24 17:25:39 CEST 2002 m68k unknown

main()
{
  char *area;
  int fd=open("/msrc/linux/distr/cd.image", O_RDWR);
  area = mmap (0, 168088*4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  if (area == -1) perror("mmap");
}

# time ./mmap
real    0m0.035s
user    0m0.020s
sys     0m0.020s

Richard
