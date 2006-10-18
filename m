Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWJRGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWJRGjs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWJRGjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:39:48 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:59844 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751448AbWJRGjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:39:47 -0400
Date: Wed, 18 Oct 2006 08:39:45 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Mohit Katiyar <katiyar.mohit@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Linux NFS mailing list <nfs@lists.sourceforge.net>
Subject: Re: NFS inconsistent behaviour
Message-ID: <20061018063945.GA5917@janus>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com> <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com> <20061016084656.GA13292@janus> <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com> <20061016093904.GA13866@janus> <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 10:22:44AM +0900, Mohit Katiyar wrote:
> I checked it today and when i issued the netstat -t ,I could see a lot
> of tcp connections in TIME_WAIT state.
> Is this a normal behaviour?

yes... but see below

> So we cannot mount and umount infinitely
> with tcp option? Why there are so many connections in waiting state?

I think it's called the 2MSL wait: there may be TCP segments on the
wire which (in theory) could disrupt new connections which reuse local
and remote port so the ports stay in use for a few minutes. This is
standard TCP behavior but only occurs when connections are improperly
shutdown. Apparently this happens when umounting a tcp NFS mount but
also for a lot of other tcp based RPC (showmount, rpcinfo).  I'm not
sure who's to blame but it might be the rpc functions inside glibc.

I'd switch to NFS over udp if this is problem.

(cc'ed to nfs mailing list)

-- 
Frank
