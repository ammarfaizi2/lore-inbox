Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTEFHEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTEFHEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:04:40 -0400
Received: from mail.zmailer.org ([62.240.94.4]:11976 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262410AbTEFHEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:04:39 -0400
Date: Tue, 6 May 2003 10:17:08 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Sumit Narayan <sumit_uconn@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Write file in EXT2
Message-ID: <20030506071708.GM24892@mea-ext.zmailer.org>
References: <FCLJBBJOHCHPBDAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FCLJBBJOHCHPBDAA@mailcity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 11:14:46PM -0400, Sumit Narayan wrote:
> Hi,
> 
> I would like to create a log file containing the reads and writes made 
> on a disk, by adding a function in the kernel. And once this log table 
> reaches a limit, say 10,000 records, I would like it to be written on 
> hard disk automatically. I am unable to do this, since I dont know how 
> to write to a file, while in the kernel. I tried System Calls, but they 
> dont seem to work. Could someone tell me what is the list of functions 
> that I need to use to do this job. I think I have to play with 
> super-blocks and inodes. But I dont know how to do that. :) Please help 
> me.


  Considering how to do that log writing:

  Kernel contains several codes that are writing data to disk for
  various "logging" tasks.  Most promimnent example of them is:

      kernel/acct.c

  It keeps kernel internal file descriptor ("filp") for its
  internal use.  It has code that opens a file for writing
  to it, actual writer (one smallish block at the time, but
  that is merely size parameter issue), and it also closes
  the file when wanted (e.g. under administrator control).

  All that completely independent of target filesystem.

  Oh, and of course it has management interface, so that
  sysadmin can tell to it:
    - when to activate / deactivate
    - into which file to log


  In your application there is a danger of snaring
  yourself:  disk activity must not stop at logging
  something, when the log buffer is full and flushing
  it is under way.  Otherwise you are in danger of
  halting the log-flush, and then you have a dead
  machine.

> Thanks.
> Sumit
> 
> p.s. I am using Kernel 2.4.20 and want this in EXT2 FS

/Matti Aarnio
