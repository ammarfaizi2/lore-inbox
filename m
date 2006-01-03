Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWACRIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWACRIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWACRIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:08:21 -0500
Received: from smtpout03-04.mesa1.secureserver.net ([64.202.165.74]:59572 "HELO
	smtpout03-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S1751475AbWACRIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:08:20 -0500
Subject: Re: high system load on tcp_poll and tcp_sock in 2.6 caused by
	squid
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: Ian Blanes <ian@gentemsn.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0601031723080.2818@workstation.zul>
References: <Pine.LNX.4.58.0601031723080.2818@workstation.zul>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 12:08:16 -0500
Message-Id: <1136308096.4965.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 17:43 +0100, Ian Blanes wrote:
> Hi,
> 
> I'm getting this report from oprofile from a squid server with about 2000
> clients. I'm not sure if this is normal... any idea on where to look?
> 
> thanks
> ian
> 
> Cpu0  : 20.0% us, 43.3% sy,  0.0% ni, 20.1% id, 15.8% wa,  0.9% hi,  0.0%
> si

oh that's going to be quite normal for any poll driven application with
a lot of concurrent connections.. think about what poll() does - it
scans all 2000 sockets and returns to you the set of ones that have
something to do.. assuming a small fraction of them meet that criteria
it does just a little work to satisfy their needs and then repeats the
process..

the epoll() style interface that is also in the kernel lets the
application essentially get change events instead of doing that big
repeated scan.. its much more efficient but it needs to be supported by
the application.



