Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUB0KQA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUB0KQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:16:00 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62219 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261809AbUB0KP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:15:58 -0500
Message-ID: <403F18C4.3080309@aitel.hist.no>
Date: Fri, 27 Feb 2004 11:15:32 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> 
> Is the assumption that hardirq handlers are superfast also the reason
> why Linux calls all handlers on a shared interrupt, even if the first
> handler reports it was for its device?
> 
No, it is the other way around.  hardirq handlers have to be superfast
because linux usually _have to_ call all the handlers of a shared irq.

The fact that one device did indeed have an interrupt for us doesn't mean
that the others didn't.  So all of them have to be checked to be safe.

If this becomes a performance problem, make sure that no _busy_ irqs
are shared.  The easy way is to shuffle pci cards around, or set
jumpers/switches or software controlled options.  Or resort to
reprogramming the APIC in extreme cases.

Helge Hafting

