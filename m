Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVCEHoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVCEHoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCEHoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:44:20 -0500
Received: from manson.clss.net ([65.211.158.2]:29332 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S262775AbVCEHnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:43:08 -0500
Message-ID: <20050305074308.22499.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: strace on cat /proc/my_file gives results by calling read twice why?
To: cranium2003@yahoo.com (cranium2003)
Date: Sat, 5 Mar 2005 02:43:08 -0500 (EST)
Cc: kernelnewbies@nl.linux.org (kernel newbies),
       linux-kernel@vger.kernel.org (kernerl mail)
In-Reply-To: <no.id> from "cranium2003" at Mar 04, 2005 11:04:21 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cranium2003 writes the following:
>
>when i strace cat /proc/my_file i found message
>printing twice
>Reading a from a /proc file....
>Reading a from a /proc file....
>       Why that happening?

The first read returns some data and returns the number of bytes, and the
second one indicates that EOF has been reached by returning 0. A single read
call can't do both of those things, so cat needs to do 2 reads.

This has nothing to do with /proc or Linux; it is a logical consequence of
the way read() is defined, and the job cat is supposed to do: it copies
entire files to stdout, so it has to read until EOF. Only if the input file
is empty will it see the EOF on the first read.
