Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTFKUBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTFKT7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:59:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:63475 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264060AbTFKT7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:59:01 -0400
Date: Wed, 11 Jun 2003 13:08:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: "jds" <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compile module vmnet VMWARE 4.0 in 2.4.70-mm8
Message-Id: <20030611130850.358276ae.akpm@digeo.com>
In-Reply-To: <20030611192737.M39931@soltis.cc>
References: <20030611192737.M39931@soltis.cc>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 20:12:44.0549 (UTC) FILETIME=[D1BA0B50:01C33055]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"jds" <jds@soltis.cc> wrote:
>
>     I have problems when compile module vmware 4.0 vmnet with kernel 2.5.70-mm8.
> 
> ...
>  
> make: Entering directory `/tmp/vmware-config0/vmnet-only'
> bridge.c: In function `VNetBridgeReceiveFromVNet':
> bridge.c:368: structure has no member named `wmem_alloc'
> bridge.c: In function `VNetBridgeUp':
> bridge.c:618: structure has no member named `protinfo'
> bridge.c: In function `VNetBridgeReceiveFromDev':
> bridge.c:817: structure has no member named `protinfo'
> make: *** [bridge.o] Error 1
> make: Leaving directory `/tmp/vmware-config0/vmnet-only'
> Unable to build the vmnet module.

You'll need to replace all instances of "wmem_alloc" with "sk_wmem_alloc"
and replace all instances of "protinfo" with "sk_protinfo".  And similar if
you get more compile errors.

Lots of socket members were renamed, by adding an "sk_" prefix.
