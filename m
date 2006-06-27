Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWF0Que@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWF0Que (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWF0Qud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:50:33 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:21190 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1161202AbWF0Qub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:50:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=ZXxgvWhKEOcLK8nDZ20sGmcmskJr8pk3RkcThIAfChu3otruL8M4wfbXLQkqQfWDuJzip/XT4DZE1JH9rESdYIx6ubED8z6Vipf7zrEZWeaJCwy1w1j2mpQtp9VB3EL8wcLuNArNkvx39L0sqjFg/eIQ3w/MCcdUcXzdAAtJQz0=;
Date: Tue, 27 Jun 2006 20:49:09 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627164909.GA20230@ms2.inr.ac.ru>
References: <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <20060627133849.E13959@castle.nmd.msu.ru> <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com> <20060627160241.GB28984@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627160241.GB28984@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 06:02:42PM +0200, Herbert Poetzl wrote:

>  - loopback traffic inside a guest is insignificantly
>    slower than on a normal system
> 
>  - loopback traffic on the host is insignificantly
>    slower than on a normal system
> 
>  - inter guest traffic is faster than on-wire traffic,
>    and should be withing a small tolerance of the
>    loopback case (as it really isn't different)

I do not follow what are you people arguing about?

Intra-guest, guest-guest and host-guest paths have _no_ differences
from host-host loopback. Only the device is different:
* virtual loopback for intra-guest
* virtual interface for guest-guest and host-guest

But the work is exactly the same, only the place where packets
looped back is different. How could this be issue to break a lance over? :-)

Alexey


PS. The only thing, which I can imagine is "optimized" out ip_route_input()
in the case of loopback. But this optimization was an obvious design mistake
(mine, sorry) and apparently will die together with removal of current
deficiences of routing cache. Actually, it is one of deficiences.
