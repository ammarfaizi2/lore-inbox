Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVCIAAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVCIAAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVCIAAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:00:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261509AbVCHXz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:55:59 -0500
Date: Tue, 8 Mar 2005 18:55:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, <paul@linuxaudiosystems.com>,
       <mpm@selenic.com>, <joq@io.com>, <cfriesen@nortelnetworks.com>,
       Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
In-Reply-To: <1110317673.5982.8.camel@mindpipe>
Message-ID: <Xine.LNX.4.44.0503081837050.4633-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Lee Revell wrote:

> I am still confused about why the LSM framework was merged in the first
> place.

The purpose of LSM is to allow different security models to be
implemented.  IMHO, a security model here meaning a complete or otherwise
significantly enhancing system-wide framework, such as SELinux.

I don't think LSM is a suitable framework for upstream merging of trivial
or experimental access control enhancements.  They should either be made
part of the core kernel under LSM control or incorporated directly into an
existing LSM.

One of the reasons I would put forward for this is that it can be
dangerous to allow the user to arbitrarily compose security modules.

Also, from an architectural point of view, it's better to think about
security models at a high level with broadly defined components (e.g.  
"DAC" and "MAC"), not as a collection of miscellaneous features.

In the case of this code, I would suggest integrating it into the core
kernel, and providing an LSM hook to allow other LSMs to mediate it.

As an example, see the vm_enough_memory hook.

- James
-- 
James Morris
<jmorris@redhat.com>


