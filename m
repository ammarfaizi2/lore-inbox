Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRKTRTH>; Tue, 20 Nov 2001 12:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKTRTA>; Tue, 20 Nov 2001 12:19:00 -0500
Received: from marine.sonic.net ([208.201.224.37]:14609 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S281170AbRKTRSq>;
	Tue, 20 Nov 2001 12:18:46 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 20 Nov 2001 09:18:38 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Message-ID: <20011120091838.B16407@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl> <200111191814.fAJIEPlQ019878@pincoya.inf.utfsm.cl> <5.1.0.14.2.20011120111439.04d42380@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20011120111439.04d42380@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 11:20:06AM +0000, Anton Altaparmakov wrote:
> find . -type d -exec chmod a+rx "{}" \;
> find . -type f -exec chmod a+r "{}" \;

That is a bit inefficient though.  It results in one fork/exec pair for
each file and each directory.

A better solution is to use find | xargs

find /path/to/dir -type d -print0 | xargs -0 chmod a+rx
find /path/to/dir -type f -print0 | xargs -0 chmod a+r

That way, xargs bunches up the arguments into as many arguments as chmod
can handle, and calls it fewer times.

The -print0 and -0 are GNU extensions to handle spaces in names.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
