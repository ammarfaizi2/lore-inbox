Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267713AbTASXNa>; Sun, 19 Jan 2003 18:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTASXNa>; Sun, 19 Jan 2003 18:13:30 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:27520 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267713AbTASXNa>;
	Sun, 19 Jan 2003 18:13:30 -0500
Subject: Re: problems with nfs-server in 2.5 bk as of 030115
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1043016608.727.0.camel@tux.rsn.bth.se>
References: <1043012373.7986.94.camel@tux.rsn.bth.se>
	 <15915.8496.899499.957528@charged.uio.no>
	 <1043016608.727.0.camel@tux.rsn.bth.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043018551.641.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 00:22:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-19 at 23:50, Martin Josefsson wrote:
> On Sun, 2003-01-19 at 23:05, Trond Myklebust wrote:
> 
> > Could you apply the following patch, so that I can see what the actual
> > returned error is?
> 
> RPC: Couldn't create pipefs entry /portmap/clnteb11b574, error -17
> RPC: Couldn't create pipefs entry /portmap/clnteb11b574, error -17
> RPC: Couldn't create pipefs entry /portmap/clnteb11b574, error -17

it appears it is this code in rpc_lookup_negative() that returns -EEXIST
I added a debug-printk and it was printed.

        if (dentry->d_inode) {
                dput(dentry);
                dentry = ERR_PTR(-EEXIST);
                goto out_err;
        }

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
