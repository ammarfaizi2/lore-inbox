Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263716AbTDDM0d (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 07:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTDDMUp (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 07:20:45 -0500
Received: from 213-84-116-84.adsl.xs4all.nl ([213.84.116.84]:37722 "HELO
	213-84-116-84.adsl.xs4all.nl") by vger.kernel.org with SMTP
	id S263696AbTDDMOz (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 07:14:55 -0500
From: David Jander <david.jander@protonic.nl>
Organization: Protonic Holland
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] ncpfs, kernel 2.4.18
Date: Fri, 4 Apr 2003 14:33:42 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <64319A7E14@vcnet.vc.cvut.cz>
In-Reply-To: <64319A7E14@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304041433.42481.david.jander@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 April 2003 13:45, Petr Vandrovec wrote:
> What they say? It is completely legal to use NULL path in ncp_obtain_info,
> and in reality ncp_obtain_mtime() in fs/ncpfs/dir.c uses NULL path
> explicitly (and it also checks for 'ncp_is_server_root(inode)', at least
> in 2.5.66 and 2.4.19). See ncp_add_handle_path, it contains code which
> converts NULL path to no path at all.
>
> Do not you just have loaded some misguided antivirus software on your
> server? ncpfs uses inode based addressing scheme, where files are accessed
> by their numbers instead of name. Only thing which accesses files by name
> are validating functions, for converting name to number, and unlink
> (because of 4.x servers crash when unlink by inode is invoked on NFS
> namespace). Petr Vandrovec

I don't use any anti-virus software, but from what you say, I may conclude the 
following:
When listing a directory with "ls", the function ncp_obtain_info() is called 
once for each entry in that directory, plus one time for the directory itself 
and (presumably) one time for the directory therunder (".." ?).
If you do this for a volume-root, you are trying to get the Original 
Name-Space of a directory under the volume, which makes the Netware-3.12 
server bark.
The error I am getting on the server goes like this: 
"GetOriginalNameSpace could not find the originating name space. DOS name was 
assumed. Use vrepair to fix this!"
If NULL paths are legal, then the problem lies elsewere (of course it does !).
If you could give me some pointers on where to look, I'll try to find out how 
to make ncpfs not call ncp_obtain_info() for the directory under a volume. 
Putting the check directly into ncp_obtain_info() doesn't seem a good place 
to me....

BTW, I am also having another problem with listing the directory contents of 
the directory where the Novell Server was mounted. I don't know if I will 
have time to get to the ground of this though, since it looks like a problem 
with the driver not handling i-nodes correctly with newer kernels. I get this 
behaviour:
-------------- CUT HERE ---------------------
linux:/mnt/Novell # ls -l
ls: .: Stale NFS file handle
linux:/mnt/Novell # cd ..
linux:/mnt # ls -l Novell/
ls: Novell/.: Stale NFS file handle
total 3
drwxr-xr-x    7 root     root          143 Feb 19 20:43 ..
drwxrwxr-x    1 david    users         512 Dec 31  1985 cdroms
drwxrwxr-x    1 david    users         512 Dec 31  1985 dataflex
drwxrwxr-x    1 david    users         512 Dec 31  1985 engineer
drwxrwxr-x    1 david    users         512 Dec 31  1985 programs
drwxrwxr-x    1 david    users         512 Dec 31  1985 sys
drwxrwxr-x    1 david    users         512 Dec 31  1985 sys1
linux:/mnt #
-------------- CUT HERE -----------------------

Thanks for the reaction...

-- 
David Jander

