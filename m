Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTIXT71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbTIXT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 15:59:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49627 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261427AbTIXT70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 15:59:26 -0400
Date: Wed, 24 Sep 2003 20:59:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: olof@austin.ibm.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] Re: /proc/ioports overrun patch
Message-ID: <20030924195926.GZ7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva> <Pine.A41.4.44.0309241437330.22232-100000@forte.austin.ibm.com> <20030924195133.GY7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030924195133.GY7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 08:51:33PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 
> Hmm...  Why not make the iterator traverse the resource tree instead?
> After all, all it takes is addition of pointer to parent resource into
> struct resource.  Goes for both 2.4 and 2.6...

Hey - it's already there.  That makes life very easy - ->next() should
do the following:
	if (resource->child)
		return resource->child;
	while (!resource->sibling) {
		resource = resource->parent;
		if (!resource)
			return NULL;
	}
	return resource->sibling;

AFAICS that should be it - walks the tree in right order.  Depth can be
trivially found by ->show(), so there's no problems either...
