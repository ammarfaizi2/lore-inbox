Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268362AbRHBSrc>; Thu, 2 Aug 2001 14:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRHBSrW>; Thu, 2 Aug 2001 14:47:22 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41232 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S268362AbRHBSrE>; Thu, 2 Aug 2001 14:47:04 -0400
Date: Thu, 2 Aug 2001 20:47:10 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010802204710.B18742@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org> <Pine.GSO.4.21.0108021431050.29563-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108021431050.29563-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Alexander Viro wrote:

> How the fuck it's expensive? It does _exactly_ the same as file fsync() -
> literally the same code. It doesn't write blocks that don't belong to
> directory. It doesn't write blocks that are clean. IOW, it does the
> minimal work possible.

fsync()ing the dir is not the minimal work possible, if e. g. temporary
files are open that don't need their names synched. Fsync()ing the
directory syncs also these temporary file NAMES that other processes may
have open (but that they unlink rather than fsync()).

Assume:

open -> asynchronous, but filename synched on fsync()
rename/link/unlink(/symlink) -> synchronous

This way, you never need to fsync() the directory, so you never sync()
entries of temporary files. You never lose important files (because the
application uses fsync() and the OS synchs rename/link etc.).

-- 
Matthias Andree
