Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJDHS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTJDHS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:18:28 -0400
Received: from smtp6.Stanford.EDU ([171.67.16.33]:65246 "EHLO
	smtp6.Stanford.EDU") by vger.kernel.org with ESMTP id S261928AbTJDHS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:18:27 -0400
Message-ID: <3F7E743A.9010601@stanford.edu>
Date: Sat, 04 Oct 2003 00:18:18 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test6: Filesystem capabilities 0.15
References: <fa.ign8c9e.3g8vr4@ifi.uio.no>
In-Reply-To: <fa.ign8c9e.3g8vr4@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:

>  This *untested* patch implements filesystem capabilities. It allows
>  to run privileged executables without the need for suid root.
>
>  Changes: - updated to 2.6.0-test6 - added lscap to show fs caps for a
>  particular file
>
>  This patch is available at:
>  <http://www.olafdietsche.de/linux/capability/>
>

I have an alternate patch, implementing file capabilities using xattrs.  
It also implements the
exec changes I proposed a few days back, but this time around it's a 
config option.  Note that
this patch is very non-intrusive.  The user API is through setxattr and 
friends, and the changes
to any filesystem to support this patch are minimal (add the 
system.capabilities xattr and
validate its contents on setxattr).

The patch and user tools are at http://www.stanford.edu/~luto/linux-fscap/
(Apply the cap- patches in order.  Patches are against 2.6.0-test6 vanilla.)

Olaf -- what do you think?  (I like your CAP_SETFCAP addition -- I may 
add it to my patch.
Currently anyone can chcap their own files, as long as they hold the 
capabilities they want
to permit.)

Example:
$ su
# cp `which ping` myping
# chmod 755 myping
# chcap cap_net_raw+p myping
# exit
$ ./myping localhost

-- Andy Lutomirski

