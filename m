Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271279AbTHHHE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271281AbTHHHE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:04:58 -0400
Received: from [66.212.224.118] ([66.212.224.118]:275 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271279AbTHHHEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:04:55 -0400
Date: Fri, 8 Aug 2003 02:53:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: Paul.Russell@rustcorp.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in fs/proc/generic.c:proc_file_read
In-Reply-To: <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0308080252260.30770@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Nagendra Singh Tomar wrote:

> In short:
> The hack used to be able to read proc files larger than 4k, breaks if the 
> caller does lseek() after read()
> 
> Detailed:
> I am providing a proc read interface to one of my proc files by using the 
> given hack symantics in which every call to read_proc() writes the data 
> starting at the begining of the page but sets "*start" artificially to 
> indicate how many fields have been read. proc_file_read then correctly 
> adjusts *ppos to signify the artificial position inside the proc file 
> where the read pointer points. It is *artificial* beacuse it is not the 
> byte offset but some other offset which only read_proc understands. Next 
> time around when read_proc gets the *ppos to start reading from it knows 
> how to calculate the exxat byte offset from the *artificial* *ppos 
> provided.
> This works fine with cat which simply calls read(). The "more" command 
> though has the following call pattern
> 
> read(fd,buf,4096) = X
> lseek(fd,X,SEEK_SET);
> 
> -- lseek modified file->f_pos to the byte offset value, which disturbed 
> read_proc ---
> 
> read(fd,buf,4096) = 0;
> 
> 
> the effect is that more never gives me data more than 4096 bytes worth.
> 
> My Question is. Is it a known problem ? 

Yep known issue, i need to get around to look and test the patch.

http://bugzilla.kernel.org/show_bug.cgi?id=952

-- 
function.linuxpower.ca
