Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUDSOSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbUDSOSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:18:04 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:29838 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264441AbUDSOPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:15:39 -0400
Date: Mon, 19 Apr 2004 16:15:36 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: x86_64 bad frame in signal deliver
Message-ID: <20040419141536.GU23938@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all!

I have got the following messages on my FTP server running x86_64:

proftpd[16913]: segfault at 0000007fbf7ff170 rip 000000000041ecaa rsp 0000007fbf7ff160 error 6
proftpd[16913] bad frame in signal deliver frame:0000007fbf7fef18 rip:41ecaa rsp:7fbf7ff160 orax:ffffffffffffffff
proftpd[17332]: segfault at 0000007fbf7ff170 rip 000000000041ecaa rsp 0000007fbf7ff160 error 6
proftpd[17332] bad frame in signal deliver frame:0000007fbf7fef18 rip:41ecaa rsp:7fbf7ff160 orax:ffffffffffffffff
proftpd[17803]: segfault at 0000007fbf7ff170 rip 000000000041ecaa rsp 0000007fbf7ff160 error 6
proftpd[17803] bad frame in signal deliver frame:0000007fbf7fef18 rip:41ecaa rsp:7fbf7ff160 orax:ffffffffffffffff
proftpd[18200]: segfault at 0000007fbf7ff170 rip 000000000041ecaa rsp 0000007fbf7ff160 error 6
proftpd[18200] bad frame in signal deliver frame:0000007fbf7fef18 rip:41ecaa rsp:7fbf7ff160 orax:ffffffffffffffff

	Does that mean that proftpd segfaulted inside user space (and is thus
buggy or even insecure) - as address rip:41ecaa suggests, or is it some kind
of kernel bug?

	The /proc/<pid of proftpd>/maps on my system suggests that
0x41ecaa is a valid code address:

/proc/9878/maps:00400000-00460000 r-xp 00000000 09:00 765659          /usr/sbin/proftpd
/proc/9878/maps:0055f000-00568000 rw-p 0005f000 09:00 765659          /usr/sbin/proftpd
/proc/9878/maps:00667000-00668000 rw-p 00067000 09:00 765659          /usr/sbin/proftpd

	Kernel is 2.6.5 on Fedora Core 1/x86_64.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
