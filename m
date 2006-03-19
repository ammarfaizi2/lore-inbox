Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWCSEL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWCSEL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 23:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWCSEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 23:11:57 -0500
Received: from web81904.mail.mud.yahoo.com ([68.142.207.183]:39513 "HELO
	web81904.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751269AbWCSEL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 23:11:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=lUn8RRu87Eh1nrDo7r2ZZTWJbA2Adt/QTeNTaduAzIhtQ2CJVQerEn3L0EMyyl2PTxwVsQEThJNm+Li/3mPTlE93/VanJR0zxB+B0WtMAojRyUctLTROVuyL2SLV/ZND4SM0n3SNWWsQdBJbjtSByfTEpznlRCyrlGiNzZDXsAk=  ;
Message-ID: <20060319041153.38692.qmail@web81904.mail.mud.yahoo.com>
Date: Sat, 18 Mar 2006 20:11:53 -0800 (PST)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
To: Andrew Morton <akpm@osdl.org>, Sean Hefty <sean.hefty@intel.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, rolandd@cisco.com,
       openib-general@openib.org
In-Reply-To: <20060318171926.7cb182fb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:

> "Sean Hefty" <sean.hefty@intel.com> wrote:
> >
> > >I'm not exactly happy that this tree adds tons of RDMA CM
> > >EXPORT_SYMBOL's that are neither currently used nor _GPL.
> > 
> > The symbols are used by the kernel component that provides userspace
> support.
> > 
> 
> There's brevity and then there is obscurity.
> 

To the point.  I, insightful betimes, but a non-user of the technology,
can grep TFM's and find out what the names could mean, but we're left
guessing at what some of these *do*.  Translating names falls into the
"any idiot can" category of data mining, but if you code for them, we can
see context.  If you named them more transparently, we might even use
them right.  Maybe just comment well?

RDMA
+EXPORT_SYMBOL(rdma_wq); Work Queue (do what to it?)
+EXPORT_SYMBOL(rdma_translate_ip); Translate IP Address
+EXPORT_SYMBOL(rdma_resolve_ip); Resolve IP Address
+EXPORT_SYMBOL(rdma_addr_cancel); Address Cancel (memory?)
+EXPORT_SYMBOL(rdma_create_id); Create (?) ID
+EXPORT_SYMBOL(rdma_create_qp); Create Queue Pair (WQ,CQ)
+EXPORT_SYMBOL(rdma_destroy_qp); Destroy Queue Pair (WQ,CQ)
+EXPORT_SYMBOL(rdma_init_qp_attr); Set Initial Queue Pair Attributes (?)
+EXPORT_SYMBOL(rdma_destroy_id); Destroy (?) ID
+EXPORT_SYMBOL(rdma_listen); Listen (to ... socket, port, pipe, what?)
+EXPORT_SYMBOL(rdma_resolve_route); Resolve Route (datagram path?)
+EXPORT_SYMBOL(rdma_resolve_addr); Resolve Address (memory?)
+EXPORT_SYMBOL(rdma_bind_addr); Bind Address (memory?)
+EXPORT_SYMBOL(rdma_connect); Connect
+EXPORT_SYMBOL(rdma_accept); Accept
+EXPORT_SYMBOL(rdma_reject); Reject
+EXPORT_SYMBOL(rdma_disconnect); Disconnect

Address vs. IP - I know we're talking about a net/dma kluge here, but the
twin usage is bugging me.  I'm intuiting the _addr as memory addresses,
rather than IP addresses, which seem to be _ip, but my poor gray goo
suffers pointer overload.

INFINIBAND
+EXPORT_SYMBOL(ib_get_rmpp_segment); Reliable MultiPacket Protocol
+EXPORT_SYMBOL(ib_copy_qp_attr_to_user); Push Queue Pair Attribute
+EXPORT_SYMBOL(ib_copy_path_rec_to_user); Push Path Record
+EXPORT_SYMBOL(ib_copy_path_rec_from_user); Retrieve Path Record
+EXPORT_SYMBOL(ib_modify_qp_is_ok); Yes, Modify Queue Pair, or "QP is
OK", or "QP was Modified OK"?
+EXPORT_SYMBOL(ip_dev_find); Find IP device (sub(/ip/, "ib")? find the
network interface device?)

> 
> Some or all of those exports have no in-tree users.
> 
> What code will use them?
> 
> Is it planned that this code be merged?

*Can* work that uses them be merged?  Code that requires a non-GPL
export?

> 
> Please explain the thinking behind the choice of a non-GPL export. 
> (Yes, we discussed this when inifiniband was first merged, but it
> doesn't hurt to reiterate).
> 

Color me curious ...
Frosty
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

