Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVERRY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVERRY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVERRY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:24:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43004 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262168AbVERRYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:24:54 -0400
Message-ID: <428B7A5F.9090404@us.ibm.com>
Date: Wed, 18 May 2005 10:24:47 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net> <428A8697.4010606@us.ibm.com> <Pine.LNX.4.62.0505171707100.18365@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505171707100.18365@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 17 May 2005, Matthew Dobson wrote:
> 
> 
>>Not a big fan of this patch.  It's not wrong, per-se, but it just doesn't
>>sit right with me.  asm-generic/topology.h should be a fallback file for
>>the arches that just want some sort of sane UP/SMP defaults.  The better
>>(IMHO) solution is this patch.  Builds fine on PPC64.
> 
> 
> And what happens if yet another function needs to be added for all arches? 
> Then ppc64 will break again and you will fix it again?

I think you explained it well yourself.  If another function needs to be
added for ALL ARCHES, then ALL ARCHES will need to add the function.  In
most cases there is no single function that is both CORRECT and GENERIC
across all arches.  The way that i386, ia64, ppc64, etc. will map PCI Buses
to Nodes (for instance) will NOT be the same.  Anyone who adds a new
topology function has the responsibility of
1) making sure it works for all arches which support topology, or
2) getting the arch maintainers involved and helping them make sure it
works for all arches.

New topology functions don't really get added all that often.  We've got
the basics (CPU, Mem, I/O Buses, Nodes) mapped in various ways, so there
shouldn't be tons of new functions added.  If someone wants to add a new
function, it's their responsibility to make sure that it doesn't break
anyone's arch.

Regardless, I highly doubt Linus or Andrew will pick up a patch for a new
topology function if it breaks some arch.

-Matt
