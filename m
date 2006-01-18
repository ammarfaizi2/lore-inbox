Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWARTiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWARTiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWARTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:38:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61380 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030256AbWARTiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:38:17 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Dave Hansen <haveblue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137612537.3005.116.camel@laptopd505.fenrus.org>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
	 <1137521557.5526.18.camel@localhost.localdomain>
	 <1137522550.14135.76.camel@localhost.localdomain>
	 <1137610912.24321.50.camel@localhost.localdomain>
	 <1137612537.3005.116.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 11:38:08 -0800
Message-Id: <1137613088.24321.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 20:28 +0100, Arjan van de Ven wrote:
> On Wed, 2006-01-18 at 11:01 -0800, Dave Hansen wrote:
> > Other than searches, there appear to be quite a number of drivers an
> > subsystems that like to print out pids.  I can't find any cases yet
> > where these are integral to functionality, but I wonder what approach we
> > should take. 
> 
> those should obviously print out the REAL pid, not the application
> pid ... so no changes needed.

One suggestion was to make all pid comparisons meaningless without some
kind of "container" context along with it.  The thought is that using
pids is inherently racy, and relatively meaningless anyway, so the
kernel shouldn't be dealing with them. (The obvious exception being in
userspace interfaces)

This would let tsk->pid be anything that it likes as long as it has a
unique pid in its container.

But, it seems that many drivers like to print out pids as a unique
identifier for the task.  Should we just let them print those
potentially non-unique identifiers, deprecate and kill them, or provide
a replacement with something else which is truly unique?

-- Dave

