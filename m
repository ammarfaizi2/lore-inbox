Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVGXLjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGXLjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 07:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVGXLjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 07:39:09 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:17619 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261450AbVGXLjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 07:39:07 -0400
Message-ID: <42E37DC7.8050001@metaparadigm.com>
Date: Sun, 24 Jul 2005 19:38:47 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <theosib@gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: HELP: NFS mount hangs when attempting to copy file
References: <9871ee5f050720155671cbc376@mail.gmail.com>	 <1122135532.8203.5.camel@lade.trondhjem.org> <9871ee5f05072319523528f2de@mail.gmail.com>
In-Reply-To: <9871ee5f05072319523528f2de@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>On 7/23/05, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
>  
>
>>I beg to disagree. A lot of these VPN solutions are unfriendly to MTU
>>path discovery over UDP. Sun uses TCP by default when mounting NFS
>>partitions. Have you tried this on your Linux box?
>>    
>>
>
>I changed the protocol to TCP and changed rsize and wsize to 1024.  I
>don't know which of those fixed it, but I'm going to leave it for now.
>
>As for MTU, yeah, the Watchguard box seems to have some hard-coded
>limits, and for whatever reason KDE and GNOME graphical logins do
>something that exceeds those limits, completely independent of NFS,
>and hang up hard.
>  
>

If possible it would also be good to fix the misconfigured VPN box
that's breaking the PMTU discovery if you can (usually it's too
aggressive blocking of ICMP messages). Although a wsize/rzise of 1024
and using TCP probably makes sense for NFS over a VPN (avoid
framentation overhead and let TCP handle the retransmission).

My guess is the Watchguard is blocking ICMP "fragmentation needed"
messages (which is resulting in the PMTU discovery breakage).

Enabling ICMP "fragmentation needed" messages to pass through the VPNs
firewall if you can should fix your other problems aswell.

~mc
