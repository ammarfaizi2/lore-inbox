Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933330AbWKWJFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbWKWJFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWKWJFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:05:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:53881 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933299AbWKWJFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:05:33 -0500
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch -mm] net namespace: empty framework
Date: Thu, 23 Nov 2006 12:05:10 +0300
User-Agent: KMail/1.9.4
Cc: Cedric Le Goater <clg@fr.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
References: <4563007B.9010202@fr.ibm.com> <456454C4.5010803@fr.ibm.com> <m1ejrvtlje.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejrvtlje.fsf@ebiederm.dsl.xmission.com>
X-Face: 'h\woBm&GL5>q=4~&$7\8J0Sv3c2a98rBl,dx/@?L4)Tg!C-nz4]2>M>=?utf-8?q?6ZwpyJ=7Ek=7EqqVT-=0A=09=7CIm?=(,W)U}CZo`G#(&OpK?El5u#-mi~%Uo)?X/qE[LE-H88#x'Y<GId$mZ]i%"iG|<=?utf-8?q?Zm/4u=0A=09Ld=2E=23=5B/Am=7D=5DV10UW0qjZUu7?=@;6SQI%Uy^H
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611231205.10773.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 20:53, Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> >> no problem here, but I think we will need another one,
> >> or some smart way to do the network isolation (layer 3)
> >> for the network namespace (as alternative to the layer 2
> >> approach) ...
> >
> > My feeling (Dmitry and Daniel can correct me) is that it will be
> > addressed with an unshare-like flag : NETNS2 and NETNS3.
> >
> >> as they are both complementary in some way, I'm not sure
> >> a single space will suffice ...
> >
> > hmm, so you think there could be a 2 differents namespaces
> > for network to handle layer 2 or 3. Couldn't that be just a sub part
> > of net_namespace.
>
> The justification is performance and a little on the simplicity side.
>
> My personal feel is still that layer 3 is something easier done
> as a new kind of table in an iptables type infrastructure.  And in
> fact I believe if done that way would capture do what 90%+ of what
> all of the iptables rules do.  So it might be a nice firewalling speed up.
Two points about solution using netfilter infrastructure:
1) Conntracks and dependant modules are called with the highest priority and 
will require, that skb context will be the same in input and output chains, 
else it will be a good place for bugs. So, we should change context before it 
will be marked by conntracks;
2) This solution has worse performance in comparison with Daniel's solution 
due to additional lookup of context by ip addr.

>
> I don't think the layer 3 idea where you just do bind filter fits
> the namespace concept very well.
>
> Eric

-- 
Thanks,
Dmitry.
