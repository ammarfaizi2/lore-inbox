Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUADDCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUADDCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:02:22 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:52232 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264586AbUADDCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:02:21 -0500
Date: Sat, 3 Jan 2004 19:02:16 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040104030216.GB7758@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it> <20040103033327.GA413@melchior.yamamaya.is-a-geek.org> <200401030415.i034FJoc006230@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401030415.i034FJoc006230@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content unsuitable for young readers.  Parental guidance is suggested.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 11:15:18PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 03 Jan 2004 04:33:28 +0100, Tobias Diedrich <ranma@gmx.at>  said:
> 
> > Very interesting tidbit:
> > 
> > with 2.6.1-rc1 and "dd if=/dev/hda of=/dev/null" I get stable 28 MB/s,
> > but with "cat < /dev/hda > /dev/null" I get 48 MB/s according to "vmstat
> > 5".
> 
> 'cat' is probably doing a stat() on stdout and seeing it's connected to /dev/null
> and not even bothering to do the write() call.  I've seen similar behavior in other
> GNU utilities.  

That is unlikely.

However, i have seen some versions of cat check the input
file and if it is mappable mmap it instead of read.  Given
that a write to /dev/null returns count without
copy_from_user the mapped page never faults so there is no
disk io.




-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
