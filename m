Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVC2AK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVC2AK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 19:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVC2AK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 19:10:58 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:62106 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262130AbVC2AKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 19:10:52 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: vherva@viasys.com
Date: Tue, 29 Mar 2005 10:10:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16968.40186.628410.152511@cse.unsw.edu.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems
In-Reply-To: message from Ville Herva on Monday March 28
References: <20050326162801.GA20729@logos.cnet>
	<20050328073405.GQ16169@viasys.com>
	<20050328165501.GR16169@viasys.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 28, vherva@vianova.fi wrote:
> On Mon, Mar 28, 2005 at 10:34:05AM +0300, [Ville Herva] wrote:
> > 
> > I just upgraded from linux-2.4.21 + vserser 0.17 to 2.4.30rc3 + vserver
> > 1.2.10. The box has been running stable with 2.4.21 + vserver 0.17/0.16 for
> > a few years (uptime before reboot was nearly 400 days.)
> > 
> > The boot went fine, but after few hours I got 
> > Message from syslogd@box at Sun Mar 27 22:07:00 2005 ...
> > kernel: journal commit I/O error

I got that error on 2.4.30-rc1 a couple of times, and now cannot
reproduce it :-(
But if you got it too, then it wasn't just bad luck.

The ext3 code in 2.4.30-rc does have a few more checks for IO errors
which will cause the journal to be aborted and produce this error, so
I suspect that change which caused the problem is a change in ext3.
However that doesn't mean the bug is there.

The extra code in ext3 seems to just check if buffer_uptodate is false
after it has waited on a locked buffer, and triggers a journal abort
if it isn't.  This should be perfectly safe, and I cannot find any
logic error near by.  But nor can I find any errors that would cause a
buffer returned from raid1 to not be uptodate (unless there really was
an IO error).


NeilBrown
