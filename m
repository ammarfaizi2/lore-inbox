Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCRPBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCRPBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCRPBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:01:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53485 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261621AbVCRPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:00:56 -0500
Date: Fri, 18 Mar 2005 07:00:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
In-Reply-To: <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
 <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
 <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Denis Vlasenko wrote:

> NT stores are not about 5% increase. 200%-300%. Provided you are ok with
> the fact that zeroed page ends up evicted from cache. Luckily, this is exactly
> what you want with prezeroing.

These are pretty significant results. Maybe its best to use non-temporal
stores in general for clearing pages? I checked and Itanium has always
used non-temporal stores. So there will be no benefit for us from this
approach (we have 16k and 64k page sizes which may make the situation a
bit different). Try to update the i386 architectures to do the same?

Or for prezeroing, you could register a zeroing driver that would use the
non-temporal stores with V8 of the prezeroing patches. In any case the
clear_pages patch is not useful the way it was intended for us and I am
have dropped this from the prezeroing patch.

