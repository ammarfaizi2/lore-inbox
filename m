Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVBIAKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVBIAKC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBIAKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:10:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261708AbVBIAJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:09:56 -0500
Date: Tue, 8 Feb 2005 19:09:44 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107906836.15942.131.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502081906290.1862-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Fruhwirth Clemens wrote:

> > You can't call kmap() in softirq context (why was it even trying?):
> 
> Why not? What's the alternative, then?

It can sleep in map_new_virtual().

The alternative is to use atomic kmaps.  For this code, unless you can 
point to something concrete in the existing kernel which would benefit 
from passing an arbitrary number of scatterlists in, just code for the 
case of processing two at once (input & output).


- James
-- 
James Morris
<jmorris@redhat.com>


