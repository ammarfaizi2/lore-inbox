Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWCHTyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWCHTyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWCHTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:54:31 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:25219 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932555AbWCHTya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:54:30 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 11:54:21 -0800
User-Agent: KMail/1.9.1
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20060308184500.GA17716@devserv.devel.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081154.21960.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 8, 2006 11:26 am, Linus Torvalds wrote:
> But if you have a separate IO fabric and basically two different CPU's
> can get to one device through two different paths, no amount of write
> barriers of any kind will ever help you.

No, that's exactly the case that mmiowb() was designed to protect 
against.  It ensures that your writes have arrived at the destination 
bridge, which means after that point any other CPUs writing to the same 
device will have their data actually hit the device afterwards.  
Hopefully deviceiobook.tmpl makes that clear...

Jesse
