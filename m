Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWBCQZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWBCQZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBCQZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:25:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35244 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751180AbWBCQZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:25:31 -0500
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled
	case
From: Dave Hansen <haveblue@us.ibm.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
In-Reply-To: <20060203140229.GA16266@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org>
	 <1138899951.29030.30.camel@localhost.localdomain>
	 <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com>
	 <20060203140229.GA16266@ms2.inr.ac.ru>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 08:25:18 -0800
Message-Id: <1138983918.6189.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 17:02 +0300, Alexey Kuznetsov wrote:
> 1. Replacing all the references to pid with pair (container, pid) is quite
> expensive. F.e. it is possible that a task has a pid from one container,
> but it is in process group and/or session of another container,
> and its controlling terminal owner by another container. Grr..
> So, the structures are bloated, the functions get additional arguments.
> And all this is for no real purpose, the functionality comparing with
> VPID is even reduced. 

I don't think anything gets bloated, at least in the default case.
Every task points to one and only one container.  Things that currently
take tasks as arguments still take tasks.  If something handling tasks
suddenly needs to worry about containers as well, we simply infer the
container from the task.

In the very, very rare cases where we can't do that (like a fork()
boundary), we _do_ change the APIs to take both task and container.
However, these are few and far between, so it isn't that much of a
headache.

In the cases where pids were referenced, and are no longer unique, we
use Eric's weak task references.  Right?

-- Dave

