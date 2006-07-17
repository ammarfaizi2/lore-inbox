Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWGQKJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWGQKJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 06:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWGQKJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 06:09:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:38462 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750702AbWGQKJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 06:09:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=QpM1ZhkSrgZ6ZCCReotKFi+aXFn+YSEYzj3Ip/j+cz/sGN4Aipe25KdnbZUFXnuuqCrXG/0OeL+/WdYcOTRsPteDE1iNuagaqH13mUP5maazH4HPdOwoOxgH7ZWNm7W4t7VF1KtsiKyt/uaqJFx/T53QCDo4amyIZ4BcrbSoBpE=
Date: Mon, 17 Jul 2006 12:08:56 +0200
From: Janos Farkas <chexum+dev@gmail.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs problems with 2.6.18-rc1
Message-ID: <priv$efbe06145615$0a94d550eb@200607.gmail.com>
Mail-Followup-To: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu> <17594.51834.20365.820166@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17594.51834.20365.820166@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-07-17 at 09:23:38, Neil Brown wrote:
> On Thursday July 13, chexum+dev@gmail.com wrote:
> > I recently updated two (old) hosts to 2.6.18-rc1, and started noticing
> > weird things with the nfs mounted /home s.
> So this is both the client and the server that you upgraded?  That
> makes is harder to point the finger of blame :-)

Yeah, smart thing :)  Thank you for the response!  When I have
downgraded the server to 2.6.17, none of those errors happened again.
(And I left the setup that way, because some programs have been
corrupting their config files because of the spurious read errors --
most notably zsh and firefox.)

> I wonder if that is pointing the finger at
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8c7b389e532e964f07057dac8a56c43465544759
> 
> as that is a recent change that returns 'EACCES'... but I cannot see
> that being relevant in this case as it only affects directories.

As far as I can see, that patch is from May 21st, and went in 17-rc5,
thus obviously 2.6.17 is newer than that...  But a bunch of nfs changes
happened in 18-rc1.

> The standard answer for tracing nfs problems if 'tcpdump'.
> e.g. 
>   tcpdump -s 0 -w /tmp/trace host $CLIENT and host $SERVER and port 2049
> 
> that should show whether the error is coming from the server, or if
> the client is generating it all by itself.

Well, I tried that, but I couldn't see errors flying on the wire.  That
would point to flaws in the 18-rc1 client (but only surfacing with an
rc1 server?), or in my eyes :)

> Also turn on tracing. Something like:
> on server
>    echo 32767 > /proc/sys/sunrpc/nfsd_debug
> on client
>    echo 32767 > /proc/sys/sunrpc/nfs_debug
> 
> You can be a bit more selective by only enabling individual flags.
> For the server, these are in include/linux/nfsd/debug.h
> You probably want FH, EXPORT AUTH PROC FILEOP
> 
> For the client, they are near the end of include/linux/nfs_fs.h
> Not sure which to choose... maybe just all of them.

Thanks, that's probably what I've been looking for.  I'll try to debug
this with a 2.6.18-rc2(client):2.6.17(server) and 2.6.18-rc2(both) setup
later this day, but those machines are currently in the process of
reorganizing their RAID config :)

-- 
Janos
romfs is at http://romfs.sourceforge.net/
