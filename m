Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267978AbTAMR56>; Mon, 13 Jan 2003 12:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbTAMR55>; Mon, 13 Jan 2003 12:57:57 -0500
Received: from [66.62.77.7] ([66.62.77.7]:36032 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id <S267978AbTAMR5u>;
	Mon, 13 Jan 2003 12:57:50 -0500
Date: Mon, 13 Jan 2003 11:06:40 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Paul Jakma <paulj@alphyra.ie>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS
 [0/6]
In-Reply-To: <Pine.LNX.4.44.0301130745510.26185-100000@dunlop.admin.ie.alphyra.com>
Message-ID: <Pine.LNX.4.44.0301131052440.20523-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Paul Jakma wrote:

> On 12 Jan 2003, Dax Kelson wrote:
> 
> > Standard NFS security/authentication sucks rocks. Without this NFS home
> > directory servers are just waiting to be ransacked by a rouge (or
> > compromised) root user on a client machine.
> 
> AIUI, A root user still can. The users krbv5 credentials will
> generally have been cached to storage. (though i suppose one could
> mount that storage via NFS and use root_squash, but that's little 
> protection.).

Well, I was trying to keep my email short. Yes, if you login to a 
compromised machine, and then obtain krbv5 credentails the evil root user 
can access/delete/modify your files stored on a RPSEC_GSS NFS server.

With RPSEC_GSS, a compromised machine, on it's own (no logged in users
except evil root), can not access/delete/modify files stored on the NFS
home directory server, which is quite different than the normal case. This 
helps when the exploit-of-the-day hits at 4am Saturday morning.

As a matter of practice you shouldn't leave cached credentials lying
around when you not logged in. Unless you have a very strong reason not
to, kill your ssh-agent and run kdestory on logout (.bash_logout and 
friends).

Dax

