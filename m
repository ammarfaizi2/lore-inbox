Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269838AbRHDIPj>; Sat, 4 Aug 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269832AbRHDIPa>; Sat, 4 Aug 2001 04:15:30 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51721 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269833AbRHDIPW>; Sat, 4 Aug 2001 04:15:22 -0400
Date: Sat, 4 Aug 2001 05:40:43 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: fdatasync(2) is also there (was: intermediate summary of ext3-2.4-0.9.4 thread)
Message-ID: <20010804054043.F16516@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010803203612.I31468@emma1.emma.line.org> <Pine.GSO.4.21.0108031506180.3272-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031506180.3272-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Alexander Viro wrote:

> Bingo. The whole thing relies on second-guessing the application.
> BTW, I can think of very legitimate cases when we want to create
> a bunch of files, fsync them as we go and then fsync the directory
> where they had been created. Application knows what and when should
> be synced _and_ it has a way to ask kernel to sync an object.

How portable is fsync()ing the directory?

How USEFUL is it to the application if all other boxen fsync() the
directory entries along with the file?

You want to sync the files, but the directory only after you created all
of the files? Use fdatasync(2) for the files - it doesn't flush meta
data, then sync the directory. It's POSIX, it's SUS v2.

Not everyone has it, though, so you may need to fall back to fsync() on
those systems.

-- 
Matthias Andree
