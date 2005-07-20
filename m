Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGTQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGTQzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 12:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGTQzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 12:55:35 -0400
Received: from palrel11.hp.com ([156.153.255.246]:38552 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261390AbVGTQzd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 12:55:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Date: Wed, 20 Jul 2005 09:55:31 -0700
Message-ID: <3689AF909D816446BA505D21F1461AE404167CFB@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Thread-Index: AcWNSNMzgYY9r57LTDiYy0L4R12niwAAbypQ
From: "Walker, Bruce J (HP-Labs)" <bruce.walker@hp.com>
To: "linux clustering" <linux-cluster@redhat.com>,
       "David Teigland" <teigland@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
       <clusters_sig@lists.osdl.org>
X-OriginalArrivalTime: 20 Jul 2005 16:55:32.0614 (UTC) FILETIME=[D76B8A60:01C58D4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Like Lars, I too was under the wrong impression about this configfs "nodemanager" kernel component.  Our discussions in the cluster meeting Monday and Tuesday were assuming it was a general service that other kernel components could/would utilize and possibly also something that could send uevents to non-kernel components wanting a std. way to see membership information/events.

As to kernel components without corresponding user-level "managers", look no farther than OpenSSI.  Our hope was that we could adapt to a user-land membership service and this interface thru configfs would drive all our kernel subsystems.

Bruce Walker
OpenSSI Cluster project
 

-----Original Message-----
From: linux-cluster-bounces@redhat.com [mailto:linux-cluster-bounces@redhat.com] On Behalf Of Lars Marowsky-Bree
Sent: Wednesday, July 20, 2005 9:27 AM
To: David Teigland
Cc: linux-cluster@redhat.com; linux-kernel@vger.kernel.org; ocfs2-devel@oss.oracle.com
Subject: [Linux-cluster] Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm

On 2005-07-20T11:35:46, David Teigland <teigland@redhat.com> wrote:

> > Also, eventually we obviously need to have state for the nodes - 
> > up/down et cetera. I think the node manager also ought to track this.
> We don't have a need for that information yet; I'm hoping we won't 
> ever need it in the kernel, but we'll see.

Hm, I'm thinking a service might have a good reason to want to know the possible list of nodes as opposed to the currently active membership; though the DLM as the service in question right now does not appear to need such.

But, see below.

> There are at least two ways to handle this:
> 
> 1. Pass cluster events and data into the kernel (this sounds like what 
> you're talking about above), notify the effected kernel components, 
> each kernel component takes the cluster data and does whatever it 
> needs to with it (internal adjustments, recovery, etc).
> 
> 2. Each kernel component "foo-kernel" has an associated user space 
> component "foo-user".  Cluster events (from userland clustering
> infrastructure) are passed to foo-user -- not into the kernel.  
> foo-user determines what the specific consequences are for foo-kernel.  
> foo-user then manipulates foo-kernel accordingly, through user/kernel 
> hooks (sysfs, configfs, etc).  These control hooks would largely be specific to foo.
> 
> We're following option 2 with the dlm and gfs and have been for quite 
> a while, which means we don't need 1.  I think ocfs2 is moving that 
> way, too.  Someone could still try 1, of course, but it would be of no 
> use or interest to me.  I'm not aware of any actual projects pushing 
> forward with something like 1, so the persistent reference to it is somewhat baffling.

Right. I thought that the node manager changes for generalizing it where pushing into sort-of direction 1. Thanks for clearing this up.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

--
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

--
Linux-cluster mailing list
Linux-cluster@redhat.com
http://www.redhat.com/mailman/listinfo/linux-cluster
