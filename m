Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWKNFZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWKNFZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 00:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbWKNFZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 00:25:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41124 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755422AbWKNFZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 00:25:36 -0500
Date: Mon, 13 Nov 2006 23:25:31 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Bill O'Donnell" <billodo@sgi.com>
Cc: Chris Friedhoff <chris@friedhoff.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061114052531.GA20915@sergelap.austin.ibm.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061109061021.GA32696@sergelap.austin.ibm.com> <20061109103349.e58e8f51.chris@friedhoff.org> <20061113215706.GA9658@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113215706.GA9658@sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill O'Donnell (billodo@sgi.com):
> On Thu, Nov 09, 2006 at 10:33:49AM +0100, Chris Friedhoff wrote:
> | Page http://www.friedhoff.org/fscaps.html updated ...
> | Kernel 2.6.18.2 updated ...
> | System keeps on humming ...
> | Is anyone else using/testing the patch? Please give feedback ...
> 
> Most likely a cockpit error, but I'm having trouble when I give the 
> capability to ping (using the userexample from your fscaps page):
> 
> $ uname -a
> Linux certify 2.6.19-rc3 #3 SMP PREEMPT Mon Nov 13 14:40:54 CST 2006 ia64
> 
> $ sudo chmod 711 /bin/ping
> $ ping -c 1 localhost
> ping: icmp open socket: Operation not permitted
> 
> $ sudo setfcaps cap_net_raw=ep /bin/ping           
> /bin/ping: Function not implemented (errno=38)
> 
> Any help is appreciated.

Hmm, two things which come to mind are (a) do you have extended
attributes compiled into your kernel and (b) is sudo properly set
up.

But for (a) to be the case, you should be getting EOPNOTZSPUP (98),
not ENOSYS (38).

Could you send me a copy of your .config, tell me which filesystem
you are using, and send the /tmp/straceout after doing

	strace -o/tmp/straceout -f setfcaps cap_net_raw=ep /bin/ping

as root?

thanks,
-serge
