Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVDQTFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVDQTFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVDQTFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:05:46 -0400
Received: from pD9F878E4.dip0.t-ipconnect.de ([217.248.120.228]:24449 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261414AbVDQTFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:05:33 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: Re: More performance for the TCP stack by using additional hardware
 chip on NIC
Date: Sun, 17 Apr 2005 21:04:29 +0200
Organization: privat
Message-ID: <d3ubvt$1ra$1@pD9F878E4.dip0.t-ipconnect.de>
References: <3Udkm-7rV-7@gated-at.bofh.it> <3Ue6L-867-19@gated-at.bofh.it> <3Ufm9-IB-3@gated-at.bofh.it> <3Ugid-1w6-25@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050405
X-Accept-Language: de, en-us, en
In-Reply-To: <3Ugid-1w6-25@gated-at.bofh.it>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau schrieb:
> Hello !
> 
> On Sun, Apr 17, 2005 at 01:29:14PM +0300, Avi Kivity wrote:
>> On Sun, 2005-04-17 at 12:07, Arjan van de Ven wrote:
>> > On Sun, 2005-04-17 at 10:17 +0200, Andreas Hartmann wrote:
>> > > Hello!
>> > > 
>> > > Alacritech developed a new chip for NIC's
>> > > (http://www.alacritech.com/html/tech_review.html), which makes it possible
>> > > to take away the TCP stack from the host CPU. Therefore, the host CPU has
>> > > more performance for the applications according Alacritech.
>> > 
>> > there are very many good reasons why this for linux is not the right
>> > solution, including the fact that the linux tcp/ip stack already is
>> > quite fast so the "gains" achieved aren't that stellar as the gains you
>> > get when comparing to windows.
>> > 
>> 
>> TOEs can remove the data copy on receive. In some applications (notably
>> storage), where the application does not touch most of the data, this is
>> a significant advantage that cannot be achieved in a software-only
>> solution.
> 
> Well, if the application does not touch most of the data, either it
> is playing as a relay, and the data will at least have to be copied,
> or it will play as a client or server which reads from/writes to disk,
> and in this case, I wonder how the NIC will send its writes directly
> to the disk controller without some help.
> 
> What worries me with those NICs is that you have no control on the
> TCP stack. You often have to disable the acceleration when you
> want to insert even 1 firewall rule, use policy routing or even
> do a simple anti-spoofing check. It is exactly like the routers
> which do many things in hardware at wire speed, but jump to snail
> speed when you enable any advanced feature.
> 
>> > Also these types of solution always add quite a bit of overhead to
>> > connection setup/teardown making it actually a *loss* for the "many
>> > short connections" types of workloads. Now guess which things certain
>> > benchmarks use, and guess what real world servers do :)
>> > 
>> 
>> again, this depends on the application.
> 
> The speed itself depends on the application. An application which
> goal is to achieve 10 Gbps needs to be written with this goal in
> mind from start, and needs fine usage of the kernel internals, and
> even sometimes good knowledge of the hardware itself.

Alacritech says, the hardware solution would make it very easy for the
application, because _every_ application would gain, without considering
the hardware it runs on itself. These are things which CEO's like to hear
- because they think, they could save time and money during development of
the application.


I don't think that it must be a problem, that on the hardware TCP stack
doesn't run any filter or other additional functions, because machines
(often clusters) with high workloads usually run on dedicated servers with
other dedicated firewall machines in front of.


I think it would be good to support this hardware, because the user can
decide afterwards (after testing), which is the best choice for his
specific application and workload.



Kind regards,
Andreas Hartmann
