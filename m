Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWDEHCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWDEHCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDEHCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:02:42 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:10439 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S1751127AbWDEHCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:02:41 -0400
Date: Wed, 5 Apr 2006 09:01:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060405070150.GA10351@k3.hellgate.ch>
References: <20060404014504.564bf45a.akpm@osdl.org> <1144187618.26812.7.camel@localhost> <20060404150953.41d7e04e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404150953.41d7e04e.akpm@osdl.org>
X-Operating-System: Linux 2.6.16 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2006 15:09:53 -0700, Andrew Morton wrote:
> Zan Lynx <zlynx@acm.org> wrote:
> > Has anyone seen this yet?
> > 
> > BUG: scheduling while atomic: mii-tool/0x00000001/2968
> >  <c02db7f7> schedule+0x43/0x540   
> >  <c02dc617> schedule_timeout+0x7a/0x95
> >  <c011d687> process_timeout+0x0/0x5   
> >  <c011e8a4> msleep+0x1a/0x1f
> >  <e09100c9> rhine_disable_linkmon+0x40/0xf1 [via_rhine]   
[...]
> 
> hmm, according to git-whatchanged, this bug has been in there since October
> last year.  Weird that it hasn't been spotted before now.

It has been spotted [1] and diagnosed [2] about two weeks ago. I guess the
reason it took so long is that in addition to the debugging options, you
need a kernel that does call the spinlock code _and_ you need to look at
the kernel log even though the behavior is unchanged.

Anyhow, the mdelay to msleep conversion is useful only for a corner case: a
user with Rhine-I hardware (ancient) who needs low latency even while
fiddling with the NIC's media settings. I am not sure it's worth the
trouble. Any suggestions for an elegant solution?

Roger

[1] http://marc.theaimsgroup.com/?l=linux-netdev&m=114321570402396
[2] http://marc.theaimsgroup.com/?l=linux-netdev&m=114349201223976
