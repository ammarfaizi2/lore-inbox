Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUAJR33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUAJR33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:29:29 -0500
Received: from rat-4.inet.it ([213.92.5.94]:10206 "EHLO rat-4.inet.it")
	by vger.kernel.org with ESMTP id S265270AbUAJR3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:29:23 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Sat, 10 Jan 2004 18:29:13 +0100
User-Agent: KMail/1.5.2
Cc: Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <200401101548.33458.ornati@lycos.it> <40002196.4030506@wmich.edu>
In-Reply-To: <40002196.4030506@wmich.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401101755.30160.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 17:00, Ed Sweetman wrote:
>
> I'm using 2.6.0-mm1 and i see no difference from setting readahead to
> anything on my extent enabled partitions. So it appears that filesystem
> plays a big part in your numbers here, not just hdd attributes or
> settings.
>
> The partition FILE is on is an ext3 + extents enabled partition. Despite
> not having fadvise (what is this anyway?) the numbers are all real and
> no error occured. Extents totally rocks for this type of data access, as
> you can see below.
>
> Stick to non-fs tests if you want to benchmark fs independent code. Not
> everyone is going to be able to come up with the same results as you and
> as such a possible fix could actually be detrimental, and we'd be stuck
> in a loop of "ide regression" mails.

To run correctly my script you _MUST_ have "fadvise" tool (my script assumes 
it is installed in current directory).

This is what Andrew said:
_____________________________________________________________________
You'll need to unmount and remount the fs in between to remove the file
from pagecache.  Or use fadvise() to remove the pagecache.  There's a
little tool which does that in 

http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
_____________________________________________________________________

so "fadvise" is a simple tool that calls "fadvise64" system call.
This system call lets you do some useful things: for example you can discard 
all the cached pages for a file, that is what my command does.

-- 
	Paolo Ornati
	Linux v2.4.24


