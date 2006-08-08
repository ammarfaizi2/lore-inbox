Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWHHR2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWHHR2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWHHR2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:28:35 -0400
Received: from [195.23.16.24] ([195.23.16.24]:59325 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S965002AbWHHR2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:28:34 -0400
Message-ID: <44D8C9BC.40102@grupopie.com>
Date: Tue, 08 Aug 2006 18:28:28 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <20060808093400.5f023ea6@localhost.localdomain> <20060808164019.GA3382@infradead.org>
In-Reply-To: <20060808164019.GA3382@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Aug 08, 2006 at 09:34:00AM -0700, Stephen Hemminger wrote:
>> Okay, does this makes kprobe's the first reflective kernel interface.
> 
> Actually kallsyms_lookup_name was the first interface like that.  And lots
> of external kprobes used it like that - in fact tcp_probe.c is the first
> one I've seen doing it differently.  But kallsyms_lookup_name is a really
> awkward lowlevel buildingblock that's almost impossible to use correctly,
> so this patch hides it behind the proper kprobes interface.

Just one side note: kallsyms_lookup_name is _really_ inefficient. The 
kallsyms structure is tailored so that kallsyms_lookup (the most 
frequently used function) is really fast. Doing it the other way around 
involves a O(N) search, uncompressing every symbol name as it goes :P

I don't think this is really a performance problem for users like 
kprobes, but I just wanted people to keep in mind that there is a 
penalty involved in calling kallsyms_lookup_name.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
