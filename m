Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSLGXZN>; Sat, 7 Dec 2002 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSLGXZN>; Sat, 7 Dec 2002 18:25:13 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:33535 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S264889AbSLGXZM>; Sat, 7 Dec 2002 18:25:12 -0500
Message-ID: <3DF2848F.2010900@drugphish.ch>
Date: Sun, 08 Dec 2002 00:30:23 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch> <20021205154822.A6762@ns1.theoesters.com> <3DEFE86A.8060906@drugphish.ch> <20021206060135.GC21070@alpha.home.local>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[Maybe we should discuss this in private, it doesn't have a lot to do 
with kernel development anymore.]

> Because when you have to deal with thousands of session per second, NAT is
> really a pain in the ass. When you have to consider security, NAT is a pain

Not with a HW LB, and with a SW LB (LVS-NAT) you can very well sustain 
20000 NAT'd load balanced connections with 5 minutes of stickyness 
(persistency) with 1GB RAM and a PIII Tualatin with 512 kb L2 cache. I'm 
not sure if you meant this when mentioning pain.

> too because it makes end to end tracking much more difficult when you deal with
> multiple proxy levels. And last but not least, there are protocols that don't

Security mustn't rely on the LB with such a high volume traffic service. 
You need a carefully designed firewall framework. At least in the setups 
I've been dealing with LBs (a couple dozen) this was the case. Load 
balancing a service with multiple proxies doing NAT certainly imposes an 
additional problem when doing proper end-to-end healthchecking, but is 
nothing that couldn't be solved or would be extremely difficult.

> like NAT. Simply think about a farm of FTP servers. It's really easy to
> load-balance internet clients on it with redirection (call it as you like) using
> a hash algorithm. NAT would be more difficult.

I agree completely with this one. Don't get me wrong, I also most of the 
time deploy a LB using the redirection method.

> I personnaly suggested and used both NAT and redirection at a big customer's
> site. NAT was there only to be compatible with broken systems that would never
> handle redirection right, in the event we would have to use them. But at the

HP/UX < 11i is such an example of horribly broken system. It can still 
be solved with direct routing (redirection, triangulation) but you need 
additional NICs.

> moment it's already the first source of architectural problems.

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

