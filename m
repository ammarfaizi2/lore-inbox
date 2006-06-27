Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWF0XNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWF0XNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWF0XNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:13:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56034 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932576AbWF0XNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:13:11 -0400
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
From: Dave Hansen <haveblue@us.ibm.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Ben Greear <greearb@candelatech.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
In-Reply-To: <20060627225213.GB2612@MAIL.13thfloor.at>
References: <20060626192751.A989@castle.nmd.msu.ru>
	 <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru>
	 <44A0FBAC.7020107@fr.ibm.com> <20060627133849.E13959@castle.nmd.msu.ru>
	 <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	 <20060627160241.GB28984@MAIL.13thfloor.at>
	 <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	 <44A1689B.7060809@candelatech.com>
	 <20060627225213.GB2612@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:12:52 -0700
Message-Id: <1151449973.24103.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 00:52 +0200, Herbert Poetzl wrote:
> seriously, what I think Eric meant was that it
> might be nice (especially for migration purposes)
> to keep the device namespace completely virtualized
> and not just isolated ...

It might be nice, but it is probably unneeded for an initial
implementation.  In practice, a cluster doing
checkpoint/restart/migration will already have a system in place for
assigning unique IPs or other identifiers to each container.  It could
just as easily make sure to assign unique network device names to
containers.

The issues really only come into play when you have an unstructured set
of machines and you want to migrate between them without having prepared
them with any kind of unique net device names beforehand.

It may look weird, but do application really *need* to see eth0 rather
than eth858354?

-- Dave

